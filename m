Return-Path: <linux-kernel+bounces-185106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBA38CB09A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E3EB245B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98743142E60;
	Tue, 21 May 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b//m+q2+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B614290C;
	Tue, 21 May 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302531; cv=none; b=H916Pgq7nVaRv+mgAWxfaBi0pqjyTkopNAw5i0A/unbJAyPo9q+qHn3aS69D248XsyYNwWEGe1H3msAWlLf2UuHhV3PkJSNocrb4XerxXPvKd/EvHAs9taW4Sdsm4shthB18+dO653ne5Ss+EQ+j0vusun+01Avk5bD1gWHYySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302531; c=relaxed/simple;
	bh=ON5wcL8qejvHBtIB0GqGXETCYrGsS6f1y+8s6Q73HFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC8kjsnG+UjBmOZCX9sTr6q0NOrTVqThdV09qGFElMWU+1zE0ti1MNldZXSteL39r6n2n8Pnp9eFGUOmjgXLocQHfSfPAAxfBatVH+dujX/MmS1WT6eAXwPz7X3cJVsqXNcbUBnL40L2TgwxFQ5tDsFhimHtbO1VwI7N8pZx0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b//m+q2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F16C2BD11;
	Tue, 21 May 2024 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716302531;
	bh=ON5wcL8qejvHBtIB0GqGXETCYrGsS6f1y+8s6Q73HFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b//m+q2+UObVUiCOikr16yDxG0LurjxfrXCsyhbwMt4BzpALAVggATIWXOhOpIloh
	 tbfdKQtpXvehafgCXotI4YCnZkVEPKJ92wcklLzrplWXhtrhwDVFk6dWMr6eES0861
	 BAe4UWxI0cB0tCG+00G7i81XDk8uzQ6aSZCEO8Zo=
Date: Tue, 21 May 2024 16:39:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <2024052136-cubbyhole-ecologist-5b68@gregkh>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkxbObACcnUMZ3LA@tiehlicka>

On Tue, May 21, 2024 at 10:28:41AM +0200, Michal Hocko wrote:
> CVE-2024-35881 to revert f341055b10bd ("drm/amd/display: Send DTBCLK
> disable message on first commit") by 3a6a32b31a11 ("Revert
> "drm/amd/display: Send DTBCLK disable message on first commit"") has
> been filed as well.
> 
> Is this really intentional? Should both be rejected?

I don't think so as we had releases with the original commit in it,
which was buggy so then the second one was needed.  So if you only took
the first fix, you have a problem, and need the second one.  If you take
both, all is good.  If you took neither, also all is good.  So be safe
and take both :)

thanks,

greg k-h

