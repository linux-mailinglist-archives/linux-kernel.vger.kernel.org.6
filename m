Return-Path: <linux-kernel+bounces-377363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112819ABDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF78C2843B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784AD1448DF;
	Wed, 23 Oct 2024 05:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gme5o/UU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD15C603;
	Wed, 23 Oct 2024 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661562; cv=none; b=hX0gi+Niptlky2I075mSGHdMJk3aZNETofN4I1psjmr8f79ht1IFJ8OUMsJ9Cmzuv2WzKfPuKnl52CjFouC9yMZfB+SKO2tV4FwsddJth7EK1Rok53t6NXW8bH0+bS2HBDXFJaf1XMSOGpFvBMGWnZfiUyyLoPTO9spYcg0VqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661562; c=relaxed/simple;
	bh=IUl8/VA1UaXKPGhrMFImpLpr1YuAPaXtMJH2JgermgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSUDb2Ec9gGCyc3k7k0xHDkaXyJMEsBIYJ9+0AIF+Bu3V7ytx81Us6gyXB+edo2edM12YKFqJhLUuDcL7kfA3xyAXMf51B5cuBeqgV1C58F9h+3JrMdOZUPwqqa4cgiFIf9odkgrA56Bjr8eBIfyNctyK6KXvDRBoUOkU+iMVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gme5o/UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9954C4CEC6;
	Wed, 23 Oct 2024 05:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729661562;
	bh=IUl8/VA1UaXKPGhrMFImpLpr1YuAPaXtMJH2JgermgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gme5o/UUp9F2KR6bU1055VofbBLMez72a/thNWlYHF5TlhAgWjpd8gjJ2M9yvLNuQ
	 S+YuEMGpEwxGjw7t3PQj08Dj2hPIXancpPfx98+UKJGAak4eMHZ/M56Nyv0StrsS8F
	 SY3TvAwl8z/NUE0CgqcbPcRuT9vY/x2SCpevI9nSvHCsvnzz4y5etTqLpQs5amSGmE
	 sADTRJqTgUDe47Ld16AEe37IPFJvrKzhFyzAYtpogsnJjDxRe8B/JFL+JTQJGNDTq5
	 BGHj5nX53K+QQYV5c02vdoc/9vMJNXGomZjhs3PyQQBp8K2pksgMS/mAbtMowLSkXZ
	 PV9Iz+67gNcrg==
Date: Wed, 23 Oct 2024 11:02:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 0/7] ASoC: fsl: add memory to memory function for ASRC
Message-ID: <ZxiKdpeuIhe/DiV4@vaman>
References: <1727247316-16156-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727247316-16156-1-git-send-email-shengjiu.wang@nxp.com>

On 25-09-24, 14:55, Shengjiu Wang wrote:
> This function is base on the accelerator implementation
> for compress API:
> https://patchwork.kernel.org/project/alsa-devel/patch/20240731083843.59911-1-perex@perex.cz/
> Add it to this patch set.
> 
> Audio signal processing also has the requirement for memory to
> memory similar as Video.
> 
> This asrc memory to memory (memory ->asrc->memory) case is a non
> real time use case.
> 
> User fills the input buffer to the asrc module, after conversion, then asrc
> sends back the output buffer to user. So it is not a traditional ALSA playback
> and capture case.
> 
> Because we had implemented the "memory -> asrc ->i2s device-> codec"
> use case in ALSA.  Now the "memory->asrc->memory" needs
> to reuse the code in asrc driver, so the patch 1 and patch 2 is for refining
> the code to make it can be shared by the "memory->asrc->memory"
> driver.
> 
> Other change is to add memory to memory support for two kinds of i.MX ASRC
> modules.

Are there any patches for tinycompress to use the new IOCTLs here, I
would like to see those changes as well

-- 
~Vinod

