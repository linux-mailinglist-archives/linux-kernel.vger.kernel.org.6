Return-Path: <linux-kernel+bounces-317801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70096E3ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB492866A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2922A1B12C7;
	Thu,  5 Sep 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DohT/nJc"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A22190055;
	Thu,  5 Sep 2024 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567479; cv=none; b=mbLuTaor5SNQoXrvKzo5hlvJTOY29ykMPPBqOp/QqUnwqz782SRxtoNiIoMUCECKHdA05ptiSA0v+HUxL5082OrgrFw/Daq4tshpyHHYhIQsnjl4Lus2u2E5fLiVjj8NXtx99PrMKqH4wygQGoQywWEMZUqB5cWclsd5wgs2SDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567479; c=relaxed/simple;
	bh=wgCX2P89enDP7fyw28TP3GzsbnztZIdW3SWCToc4tzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hc2ClghhX9vzzi0Cp9uvTOWI085Xt5dise9vx3wuVj1Y0q/lrmTupHRvpPs6igeiP1eVT9V+iKG2IQT0WBjvzpM13+wv7hsWkO1HXItQp+zbiyfeSCEOjPadc5g3IdS592lli0y3s3q7G6lbr/Crfs7EvO9SrlQlDnOw62+Wn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DohT/nJc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1DE8242B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725567477; bh=UqWrUmM2bMyQ/iZJMIRa6thiolbg9GoeQe+ABfT/Rq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DohT/nJc3RtO2qLcUB/tbJgJDk7pMc5XlWtUiDMX2fg1rfUjmUcQwbgP5ACDdIWHQ
	 Cmig/HiD9SHbr7Dzova25igWIcsxx2BHb98Vu/tjiQDfbZA0DCqyXdav7vf6AfgmDo
	 dMU2pLJNipCe7T9EtfhfnNLlQwqiTLBojnXZ+lJhOdfpHSqMNpbTr3tqbdvLW88cD6
	 rsjIaWXq8w7Bno+H0jTMDjk1LGERJYtxX/qjV3Wqd0GS0cSmIPaadLrGsPU5mJkpba
	 8aJjsbWeLfrcp0MDI1Fwls99cUw3S5MnGCx0uAmjX0saA9jesZhfaowMW5MFSqsGXT
	 kOxCk8gy0lVFg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1DE8242B25;
	Thu,  5 Sep 2024 20:17:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, I Hsin Cheng
 <richard120310@gmail.com>
Subject: Re: [PATCH] docs: scheduler: completion: Update member of struct
 completion
In-Reply-To: <20240828165036.178011-1-richard120310@gmail.com>
References: <20240828165036.178011-1-richard120310@gmail.com>
Date: Thu, 05 Sep 2024 14:17:56 -0600
Message-ID: <87h6athn2j.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I Hsin Cheng <richard120310@gmail.com> writes:

> The member "wait" in struct completion isn't of type wait_queue_head_t
> anymore, as it is now "struct swait_queue_head", fix it to match with
> the current implementation.
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  Documentation/scheduler/completion.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/scheduler/completion.rst b/Documentation/scheduler/completion.rst
> index f19aca2062bd..adf0c0a56d02 100644
> --- a/Documentation/scheduler/completion.rst
> +++ b/Documentation/scheduler/completion.rst
> @@ -51,7 +51,7 @@ which has only two fields::
>  
>  	struct completion {
>  		unsigned int done;
> -		wait_queue_head_t wait;
> +		struct swait_queue_head wait;
>  	};

Applied, thanks.

jon

