Return-Path: <linux-kernel+bounces-397684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF109BDEFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B5328472D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6D192B61;
	Wed,  6 Nov 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FJcMtEHy"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4917995E;
	Wed,  6 Nov 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875625; cv=none; b=NBuB9Fck8jgZj8UtNQk5/m5fpeW+GN8qNqqMaZCClGIkqYsFjzHiblbKGNymi5SlNQ6VQFAr8fV67SOY5gpsAIL1TzUPAn/qeVMNrtHnoTLi4t+w/RXU7D0cS7FUqkdm30pMEAwpPXovt7DH3VUaNQuU/oDHBTRFnoG/i5/TKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875625; c=relaxed/simple;
	bh=R6xU0CG0JVOsK28xl4wfoSihcnxNMnuC7uvoSjkp/Mo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MIyyd+bcE4NhanLr1Bhup0+ndaYYZi/+I8V1TkvR1m6OPma+uCptcf9jFy4s2h5APiKIaBBchGeNdRr+RQs/hteE3Wp1YJNL0xfWJva+Jnj9U6wF5bmggilUTXZhr7Dg5cyNxJaRghZvHhzzePNaMT47k++p/Gql13sdrMinI7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FJcMtEHy; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730875621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fes0DCao26FBIpxfJIxE0I8Zn8dlbC9mrrRVdNzfHLk=;
	b=FJcMtEHymvisNaYC0PPShiF1BZMbLwLsJe0OItVNDZI8mfXZwqE2/pngmRSNyEuQu1+Feg
	sH6+V1/A/0TPm935MfkkcoNJjRKLRy1Uwsy+gpNZfChA9ir0FSzpr9dmznotwmx2v11z7a
	qdjB/etSEynTVXpXSAWAiyY5h+ONkpwPdbZyuYf28ykF5JErfvwQzYdTymkQQcuXru1/4j
	aw49Pq5bTGsJSh8SUg+ZTFWanAQhjLx4J1ygQae/vZE9Mu8Xm9Me8H6zTBsFo1xffzJMwl
	uVANtUA2URfcfDza4r9BKBe9vE9zNbBAEY+LPDRAYkb23+Wib+HB2QrTwBVyzA==
Date: Wed, 06 Nov 2024 07:47:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: apw@canonical.com, joe@perches.com, corbet@lwn.net
Cc: dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, wens@csie.org
Subject: Re: [PATCH v2 3/3] docs: submitting-patches: Describe the use of
 Helped-by tag
In-Reply-To: <55056f4ec0365c67576a1e1e3162b0cfeadd1c6d.1730874296.git.dsimic@manjaro.org>
References: <cover.1730874296.git.dsimic@manjaro.org>
 <55056f4ec0365c67576a1e1e3162b0cfeadd1c6d.1730874296.git.dsimic@manjaro.org>
Message-ID: <33204d0882909375801a2b0c74b5354c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-11-06 07:28, Dragan Simic wrote:
> Add the description of the intended use of Helped-by tags, which give 
> credit
> to the persons who assisted the patch authors in a way that didn't 
> actually
> contribute to the patch directly, i.e. at the source-code level.
> 
> Suggested-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/process/submitting-patches.rst | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst
> b/Documentation/process/submitting-patches.rst
> index 382c49659cb9..d0d12536ab68 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -452,8 +452,8 @@ as it was propagated to the maintainers and
> ultimately to Linus, with
>  the first SoB entry signalling primary authorship of a single author.
> 
> 
> -When to use Acked-by:, Cc:, and Co-developed-by:
> -------------------------------------------------
> +When to use Acked-by:, Cc:, Co-developed-by:, and Helped-by
> +-----------------------------------------------------------

Oh, now I see that I've missed a colon after Helped-by in the section
title above. :/  Would you like me to send a v3 with the fix, or do you
prefer to fix it by hand before applying the patch?

>  The Signed-off-by: tag indicates that the signer was involved in the
>  development of the patch, or that he/she was in the patch's delivery 
> path.
> @@ -495,6 +495,14 @@ chronological history of the patch insofar as
> possible, regardless of whether
>  the author is attributed via From: or Co-developed-by:.  Notably, the 
> last
>  Signed-off-by: must always be that of the developer submitting the 
> patch.
> 
> +Helped-by: gives attribution to the persons that helped the patch 
> authors
> +in a way that didn't directly produce the patch itself.  For example, 
> someone
> +may provide significant assistance to the authors by researching the 
> schematic
> +of a device that the patch addresses, or by providing the patch 
> authors with
> +some background information required to develop the patch, while 
> contributing
> +no actual source code.  As a result of no direct patch authorship, no
> +Signed-off-by: tags are needed together with Helped-by: tags.
> +
>  Note, the From: tag is optional when the From: author is also the 
> person (and
>  email) listed in the From: line of the email header.

