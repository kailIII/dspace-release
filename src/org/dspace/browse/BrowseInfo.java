/*
 * BrowseInfo.java
 *
 * Version: $Revision$
 *
 * Date: $Date$
 *
 * Copyright (c) 2001, Hewlett-Packard Company and Massachusetts
 * Institute of Technology.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * - Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 *
 * - Neither the name of the Hewlett-Packard Company nor the name of the
 * Massachusetts Institute of Technology nor the names of their
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */

package org.dspace.browse;


import java.util.*;


/**
 * Results of a Browse method call.
 *
 * The List RESULTS are the objects returned from the browse; either
 * Strings (for getAuthors()) or org.dspace.content.Items (for all
 * the getItems.... methods). The list is readonly, and is guaranteed
 * to be non-null.
 *
 * overallPosition is the position of the first element of results
 * within the Browse index. Positions begin with 0.
 *
 * total is the number of objects in the index. Note that this is a
 * snapshot, which is only guaranteed to be correct at the time the
 * browse method was called.
 *
 * offset is the position of the requested object within the results.
 * This position is also 0-based.
 */

public class BrowseInfo
{

    /**
     * The results of the browse
     */
    private List results;

    /**
     * The position of the first element of results
     * within the Browse index. Positions begin with 0
     */
    private int overallPosition;

    /**
     * The position of the requested object within the results.
     * Offsets begin with 0.
     */
    private int offset;

    /**
     * The total number of items in the browse index
     */
    private int total;

    /**
     * Constructor
     *
     * @param results - A List of Browse results
     * @param overallPosition - The position of the first returned item in the overall index
     * @param total - The total number of items in the index
     * @param offset - The position of the requested item in the set of results
     */
    public BrowseInfo (List results,
        int overallPosition,
        int total,
        int offset
    )
    {
        if (results == null)
            throw new IllegalArgumentException("Null result list not allowed");

        this.results = Collections.unmodifiableList(results);
        this.overallPosition = overallPosition;
        this.total = total;
        this.offset = offset;
    }

    /**
     * The results of the Browse.
     * The results can contain either Strings (for the authors browse)
     * or org.dspace.content.Items (for the other browses).
     *
     * @return - Result list. This list cannot be modified.
     */
    public List getResults()
    {
        return results;
    }

    /**
     * Return the number of results.
     *
     * @return - the number of results.
     */
    public int getResultCount()
    {
        return results.size();
    }

    /**
     * Return the position of the results in index being browsed.
     * This is 0 for the start of the index.
     *
     * @return - the position of the results in index being browsed.
     */
    public int getOverallPosition()
    {
        return overallPosition;
    }

    /**
     * Return the total number of items in the index.
     *
     * @return - The total number of items in the index.
     */
    public int getTotal()
    {
        return total;
    }

    /**
     * Return the position of the requested item or value in the set of results
     *
     * @return - the position of the requested item or value in the set of results
     */
    public int getOffset()
    {
        return offset;
    }

    /**
     * True if there are no previous results from the browse
     *
     * @return - True if there are no previous results from the browse
     */
    public boolean isFirst()
    {
        return overallPosition == 0;
    }

    /**
     * True if these are the last results from the browse
     *
     * @return - True if these are the last results from the browse
     */
    public boolean isLast()
    {
        return overallPosition + results.size() == total;
    }
}
