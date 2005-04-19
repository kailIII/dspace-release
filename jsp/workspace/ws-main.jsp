<%--
  - ws-main.jsp
  -
  - Version: $Revision$
  -
  - Date: $Date$
  - Copyright (c) 2002, Hewlett-Packard Company and Massachusetts
  - Institute of Technology.  All rights reserved.
  -
  - Redistribution and use in source and binary forms, with or without
  - modification, are permitted provided that the following conditions are
  - met:
  -
  - - Redistributions of source code must retain the above copyright
  - notice, this list of conditions and the following disclaimer.
  -
  - - Redistributions in binary form must reproduce the above copyright
  - notice, this list of conditions and the following disclaimer in the
  - documentation and/or other materials provided with the distribution.
  -
  - - Neither the name of the Hewlett-Packard Company nor the name of the
  - Massachusetts Institute of Technology nor the names of their
  - contributors may be used to endorse or promote products derived from
  - this software without specific prior written permission.
  -
  - THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  - ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  - LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  - A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  - HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  - INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
  - BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
  - OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  - ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
  - TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
  - USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
  - DAMAGE.
  --%>

<%--
  - Workspace Options page, so the user may edit, view, add notes to or remove
  - the workspace item
  -
  - Attributes:
  -    wsItem   - WorkspaceItem containing the current item to be worked on
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="org.dspace.app.webui.servlet.MyDSpaceServlet" %>
<%@ page import="org.dspace.content.DCValue" %>
<%@ page import="org.dspace.content.Item" %>
<%@ page import="org.dspace.content.WorkspaceItem" %>
<%@ page import="org.dspace.eperson.EPerson" %>

<%
    // get the workspace item from the request
    WorkspaceItem workspaceItem =
        (WorkspaceItem) request.getAttribute("wsItem");

    // get the title and submitter of the item
    DCValue[] titleArray =
         workspaceItem.getItem().getDC("title", null, Item.ANY);
    String title = (titleArray.length > 0 ? titleArray[0].value : "Untitled");
    EPerson submitter = workspaceItem.getItem().getSubmitter();
%>

<dspace:layout title="My DSpace">

    <table width="100%" border=0>
        <tr>
            <td align=left>
                <H1>
                    WorkSpace Item
                </H1>
            </td>
            <td align=right class=standard>
                <dspace:popup page="/help/index.html#mydspace">Help...</dspace:popup>
            </td>
        </tr>
    </table>

    <h2><%= title %></h2>
    <strong><A HREF="mailto:<%= submitter.getEmail() %>"><%= submitter.getFullName() %></A></strong>
    <br/><br/>
    This item is being submitted to the collection: 
    <%= workspaceItem.getCollection().getMetadata("name") %>
    <br/><br/>

    <table class=miscTable align=center>
        <tr>
            <th class=oddRowOddCol>Option</th>
            <th class=oddRowEvenCol>Description</th>
        </tr>
        <tr>
            <td class="evenRowOddCol" align="center">
                <form action="<%= request.getContextPath() %>/mydspace" method="POST">
                <input type="hidden" name="step" value="<%= MyDSpaceServlet.MAIN_PAGE %>"/>
                <input type="hidden" name="workspace_id" value="<%= workspaceItem.getID() %>"/>
                <input type="hidden" name="resume" value="<%= workspaceItem.getID() %>"/>
                <input type="submit" name="submit_resume" value="Edit"/>
                </form>
            </td>
            <td class="evenRowEvenCol">
                Open the item up for editing and file management.
            </td>
        </tr>
        
        <tr>
            <td class="oddRowOddCol" align="center">
                <form action="<%= request.getContextPath() %>/view-workspaceitem" method="post">
                <input type="hidden" name="workspace_id" value="<%= workspaceItem.getID() %>"/>
                <input type="submit" name="submit_view" value="View"/>
                </form>
            </td>
            <td class="oddRowEvenCol">
                View the item record as it stands at this stage of submission.
            </td>
        </tr>
        
        <tr>
            <td class="evenRowOddCol" align="center">
                <form action="<%= request.getContextPath() %>/mydspace" method="post">
                <input type="hidden" name="step" value="<%= MyDSpaceServlet.MAIN_PAGE %>"/>
                <input type="hidden" name="workspace_id" value="<%= workspaceItem.getID() %>"/>
                <input type="submit" name="submit_delete" value="Remove"/>
                </form>
            </td>
            <td class="evenRowEvenCol">
                Remove the item all together.
            </td>
        </tr>

    </table>

<P><A HREF="<%= request.getContextPath() %>/mydspace">Return to My DSpace</A></P>

</dspace:layout>