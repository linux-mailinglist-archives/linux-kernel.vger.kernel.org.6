Return-Path: <linux-kernel+bounces-545517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E934A4EE18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AEC188F401
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA125F975;
	Tue,  4 Mar 2025 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XSrcvZdj"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF91FA243;
	Tue,  4 Mar 2025 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119021; cv=none; b=bDtLL/agTXUBCXbfM5OM0Mv0g0ekFIWw4wA+z7Qe30G52T63ZlTvWvDLzNAD7urU01vhjXhfLVmThdNJnD5FdLvVCqZAz8PSGOlKRHcuEQfqm0yY2srNX9SixfNNSRRpAY8wM9pCdsUFx/QjC21MuygMEauQZhP9/+u9YuqRLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119021; c=relaxed/simple;
	bh=DRUKdQj5oTVlezh9mo56uJhXpch/Uu+umMQeE2aZTvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAij+dh/c2qZOIG6iWb2qyCnf1ZJzjpOuH+7Do4cqkDs7RMrxdjTE9mYsjXF7BFEmwQxWHMIipjq6pYge45EG2PsPbcfWwOHbArIR1yy9D5KIGzWs0Nf+a3xFeM6ZLx+e4Cs61oerfVzeB7ei9L0nwk6D3E10DIJSlrcnlbqVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XSrcvZdj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B2E17E6;
	Tue,  4 Mar 2025 21:08:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1741118917;
	bh=DRUKdQj5oTVlezh9mo56uJhXpch/Uu+umMQeE2aZTvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSrcvZdjhS/17NmoviIPT7lLMn7HPhNRW6gyTFDzw+RQsoPIjzpQfs1ctaMr9ITRi
	 /Bs7KohGew6eM7EoMdjGtEsKBO3S6MvMOAyoGGAq7QuDrpmi+9XTCImur8fZTYiqe0
	 Fvg0SKBT5YkFH/Snz7dT3DHl7anPhIhvllPHL1m8=
Date: Tue, 4 Mar 2025 22:09:47 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Shuah Khan <shuah@kernel.org>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	conduct@kernel.org, tab@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Documentation/CoC: Spell out the TAB role in enforcement
 decisions
Message-ID: <20250304200947.GF30583@pendragon.ideasonboard.com>
References: <20250304194813.11049-1-shuah@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304194813.11049-1-shuah@kernel.org>

Hi Shuah,

Thank you for the patch.

On Tue, Mar 04, 2025 at 12:48:12PM -0700, Shuah Khan wrote:
> Updates to clarify and spell out the TAB role in approving and overturning
> enforcement measures for Code of Conduct violations.

As with any technical change, I think it would help reviewers if the
commit message could explain *why* this change is appropriate at this
time. For instance, it would be good to know if this is meant to ensure
the document clearly describes the existing practices without a change
of rules, or if there's another reason.

Without an explanation of the intent, the CoC and TAB would appear more
opaque, especially given the tags present on v1 that shows the patch has
been discussed behind closed doors.

> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  .../process/code-of-conduct-interpretation.rst  | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
> index 1d1150954be3..4cdef8360698 100644
> --- a/Documentation/process/code-of-conduct-interpretation.rst
> +++ b/Documentation/process/code-of-conduct-interpretation.rst
> @@ -145,13 +145,16 @@ kernel community.
>  
>  Any decisions regarding enforcement recommendations will be brought to
>  the TAB for implementation of enforcement with the relevant maintainers
> -if needed.  A decision by the Code of Conduct Committee can be overturned
> -by the TAB by a two-thirds vote.
> +if needed.  Once the TAB approves one or more of the measures outlined
> +in the scope of the ban by two-thirds of the members voting for the

There was no mention of "ban" in this section, is the addition of that
word on purpose ?

> +measures, the Code of Conduct Committee will enforce the TAB approved
> +measures.  Any Code of Conduct Committee members serving on the TAB will
> +not vote on the measures.

We're switching from a 2/3 majority to *not* implement a recommendation
to a 2/3 majority to implement it. Without judging the merit of this (at
first sight I feel positive about the change), I think it's worth
explaining why.

>  
>  At quarterly intervals, the Code of Conduct Committee and TAB will
>  provide a report summarizing the anonymised reports that the Code of
>  Conduct committee has received and their status, as well details of any
> -overridden decisions including complete and identifiable voting details.
> +TAB approved decisions including complete and identifiable voting details.
>  
>  Because how we interpret and enforce the Code of Conduct will evolve over
>  time, this document will be updated when necessary to reflect any
> @@ -227,9 +230,11 @@ The scope of the ban for a period of time could include:
>         such as mailing lists and social media sites
>  
>  Once the TAB approves one or more of the measures outlined in the scope of
> -the ban by a two-thirds vote, the Code of Conduct Committee will enforce
> -the TAB approved measure(s) in collaboration with the community, maintainers,
> -sub-maintainers, and kernel.org administrators.
> +the ban by two-thirds of the members voting for the measures, the Code of
> +Conduct Committee will enforce the TAB approved measure(s) in collaboration
> +with the community, maintainers, sub-maintainers, and kernel.org
> +administrators.  Any Code of Conduct Committee members serving on the TAB
> +will not vote on the measures.
>  
>  The Code of Conduct Committee is mindful of the negative impact of seeking
>  public apology and instituting ban could have on individuals. It is also

-- 
Regards,

Laurent Pinchart

