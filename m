Return-Path: <linux-kernel+bounces-447690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1A79F3615
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622681888794
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9120629B;
	Mon, 16 Dec 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyDiUY8T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377A200A0;
	Mon, 16 Dec 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366505; cv=none; b=OjRyOLYjjElenUMbT9GnHv9HvY4FgUrz+IROV7RKSAmYItFEp4/ZjTp3abe4mQ0AiYZ2z8jUSZusihFDuVbH5VISnhCtdRlKAORt8gbkJ8Hbk9bjFn7K0OMjrvN98Dv7lxItaGZrZZS2nED4IYIQU6Xy2UnuZazVqNnj2gx0wDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366505; c=relaxed/simple;
	bh=tMPEpmeVp+B0QYRRirQr0XuXDB7+Z0ZvxOKJNFfCgTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqtSpXr/FuqzH14oCHEQS/VhJeHVNDpFmvM7lFqRSQhZ/rOhR6HD8ooXrW5kpw5mT+AtRK+UrWwZLX+9q6Hxx6Qm/ZSBB8vlrwqX70ItcQxKlGKHXNEzNby/qEvjQUWGAe9omDEoyTuSJpionHGD5FoBI86EXsGT0YLol6EccT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyDiUY8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78484C4CED0;
	Mon, 16 Dec 2024 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366505;
	bh=tMPEpmeVp+B0QYRRirQr0XuXDB7+Z0ZvxOKJNFfCgTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyDiUY8T46fXZXZ4r15wn7VkcOdqRmHmKae00Sga6KEusDPBNuySkcnasKSNDYGsT
	 JnVKk14ZVaIQPUCsI7QTmBe8e3y1HjC93f3QWd7GtvQHWLiLykVBy+xxXYq+X9fKS0
	 Ju5gssP1/CrJr2rD2AGZnIS0tvxA6YEmcyCHAcW+4C5dZksgTz8f3bbKziN8IK4i7X
	 mSonM1PDdTpVS3IRul4KrFLDByp7SQFj6qSFbEbPiQZGIKCazwovQUkB1HmwVGoD0o
	 nkIVLDyJEfoZcmzPDc8GkCpX2BMrYX8n1F2JqVLQcn6qZr0Wdl0aT37X+I79AeBHVN
	 4uYI/czJ9/S+g==
Date: Mon, 16 Dec 2024 21:58:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Yu Jiaoliang <yujiaoliang@vivo.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: compress_offload: import DMA_BUF namespace
Message-ID: <Z2BVJZBce7rtsfEa@vaman>
References: <20241216093410.377112-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216093410.377112-1-arnd@kernel.org>

On 16-12-24, 10:33, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The compression offload code cannot be in a loadable module unless it
> imports that namespace:

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod

