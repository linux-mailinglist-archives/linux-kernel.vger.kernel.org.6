Return-Path: <linux-kernel+bounces-188856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73588CE7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAA91F21ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A7C12DDA5;
	Fri, 24 May 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ySVIarrI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD612DD98;
	Fri, 24 May 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564463; cv=none; b=Dq3Ae6XBp8pi2rplNd02cHarGK6qeec1fN0ZRVZ9xVz6xlwtpkOYBD+T1sJjObu1BHVBqw1BxAhdL/X5KdwJLVMeJwd5W2xm1lKF9u6hz0qJd/SXk0IADHuenf9TharA1JB3NlCK0YY1SLwMO6g3VmjopgpIo7I7PIx7h4esZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564463; c=relaxed/simple;
	bh=EWjF42HyXFIgPE/ta6fPNwbxqec2D+5L3iGHiCR4VVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUIvRG/qSqlobwgvDioP4rE/qR8Pb0j0/jP6DhzlXwHzyGQkASa745b0DIc826zmWSwacOMozYHUf1AxVqDWKm/vbChn3Rk0gXk4M99HItUUMAp2oFHwHAZ4W8IaVIk2/5s50LfACkDr9wxgM++NBQGI5sHH9qBOlc7oF1XJ+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ySVIarrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D2FC2BBFC;
	Fri, 24 May 2024 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716564462;
	bh=EWjF42HyXFIgPE/ta6fPNwbxqec2D+5L3iGHiCR4VVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ySVIarrIR6ZWmjPpQVVQ9tWKvUgXSa6m1ze/sqoVetRaVplOtZC/3uK+7FFWyCtmu
	 tHdk1KijyfvxBZx0nonTxR8+lddXEXVXPa1RjyMy66uQiXI+TThy/cnhT/ux+zW1YS
	 XXBmXfuFAYjKCXx0bObb7N7LcHSo/fBkpyA7yWC8=
Date: Fri, 24 May 2024 17:27:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <2024052431-decline-limes-da66@gregkh>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
 <2024052420-clang-flatterer-366b@gregkh>
 <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
 <ZlCgoTr27AT_eg9A@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlCgoTr27AT_eg9A@dwarf.suse.cz>

On Fri, May 24, 2024 at 04:13:53PM +0200, Jiri Bohac wrote:
> On Fri, May 24, 2024 at 02:38:04PM +0200, Jiri Bohac wrote:
> > On Fri, May 24, 2024 at 12:15:47PM +0200, Greg Kroah-Hartman wrote:
> > > Nice, but then why was this commit worded this way?  Now we check twice?
> > > Double safe?  Should it be reverted?
> > 
> > double safe's good; turning it into a CVE not so much :(
> > CVE-2023-52822, CVE-2023-52824 and CVE-2023-52820, originally from the same patch
> > series, seem to be the exact same case.
> 
> Same thing: CVE-2023-52758

Agreed, now rejected, thanks for the review!

greg k-h

