Return-Path: <linux-kernel+bounces-369247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C19A1AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65A31F23E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9E41925A5;
	Thu, 17 Oct 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrWUBCyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80241917E5;
	Thu, 17 Oct 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147033; cv=none; b=q8jBicEDZfLJ7zcuG2iBJZ7m87pIaztO3ovQTjlRluHNgkokz1mjRlXYGszpxsps+LVywpFH/NQ+jFVaN9tKqbaW5njIxIKnUSMg4B+A5DonRuBPJMSUwqGe273QrAnzr/1kxInPLXJWnoXePrsE4FfmAl9IjbD16rvGCOK3rdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147033; c=relaxed/simple;
	bh=J46znkNGsGhxVc2XFpJfW2+IcYnxRbvmuWZoBnkWax0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8vCJB356sjqXgIccpL+yOF3621WiUTRCNkLo7z3J1hsgBmQ0CIhaNg1UHtIhI7A/hSfKAigWGx5h77nXwhMyEw0TMB8KXQbvCpgDm1LXC2uWgbV9uRBWO1U3/ql8CtRyui9FZI/RE8IOP/1pwwC0xFFusHvyNRZh/RdaxD2Rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrWUBCyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5CDC4CEC3;
	Thu, 17 Oct 2024 06:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729147033;
	bh=J46znkNGsGhxVc2XFpJfW2+IcYnxRbvmuWZoBnkWax0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrWUBCyl5OM6ybWonkxQHxrK+2Fa0TyT2CNtmjyOwfkYXp/UB84vOYXHdBAg5zcmO
	 O6A2b4ej1fuDgWl8kMUaryRH+dnNx1q72Yn1YI2Bdp8CJBzcjnngyOP5QoQ007uCeX
	 KhKMPBpAjD+rNs6ZJTwqJEtyXj19WwjOtbYHapeb9YEu/GuO+w305AVEINz0LvlYXz
	 xn0Z+OKm464WBR4ItMM3U7Qh+f5LTuJSIa2y3WfGbCLssw98/H/nXFCDfVDUQVdEBd
	 TfUXo+DqTQQ45UNgYDzvRm/2g5BHOov/zRgml5IMZ7Ge1FbRiYTbn92U/U9yvKON9L
	 9r6gymTUWtO8A==
Date: Thu, 17 Oct 2024 12:07:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: broonie@kernel.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, pierre-louis.bossart@linux.dev,
	bard.liao@intel.com, ranjani.sridharan@linux.intel.com
Subject: Re: [PATCH 3/4] soundwire: intel_ace2x: Send PDI stream number
 during prepare
Message-ID: <ZxCwlYBP4OUFhXR5@vaman>
References: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
 <20241016032910.14601-4-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016032910.14601-4-yung-chuan.liao@linux.intel.com>

On 16-10-24, 11:29, Bard Liao wrote:
> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> In the case of a prepare callback after an xrun or when the PCM is
> restarted after a call to snd_pcm_drain/snd_pcm_drop, avoid
> reprogramming the SHIM registers but send the PDI stream number so that
> the link DMA data can be set. This is needed for the case that the DMA
> data is cleared when the PCM is stopped and restarted without being
> closed.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

