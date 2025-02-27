Return-Path: <linux-kernel+bounces-535702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0CAA47636
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868FD188FC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B4C21B9CB;
	Thu, 27 Feb 2025 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffa++XjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB08BEC;
	Thu, 27 Feb 2025 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639720; cv=none; b=G1wuj8It4AjowvVepm5B71z6Du5aAicLFA+60FEYQNZXHuQj0dv5no2JJSIinqLJr1RzpdLHPgdtrE2EOdN6Z1t5Bp6+ADQnBjcekx5GgE+7SSpG5uCBlH4uGnuEH4SBrUiNky82dpDWp+bbqhJQW+3Idu/RBrADKp+Ru/lyPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639720; c=relaxed/simple;
	bh=AbENd3rh+ZqB84Y0VY+S3ZID/ZQPE1RX+fpvwRkj3xA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lVP3Ll0CmFi74rAj2GZD5XrpR2LLoBIJkM8Suqlv0XgFgXPXbLupvM+bcy8V4EVW5/XI31is1Je3La9X3qjEKyEVqQNKmZb/XnRbbIqZIUwkWOUtM0JX6wFTxWQajaRsOul4FURZ3Nzz3wAc3CQUIgmli1Z4GeP+w32c0QMToFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffa++XjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C75C4CEDD;
	Thu, 27 Feb 2025 07:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740639720;
	bh=AbENd3rh+ZqB84Y0VY+S3ZID/ZQPE1RX+fpvwRkj3xA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ffa++XjSc94ZsuP7KA/LgNaUHH4FycIC9WVCJG/n2q+JCRIBeDdlY58+iAux2JsYp
	 UasMgQx6bF8Fv7jHimGGibFavqeK95pQ/F3odsByOFxpe7Qqlg84cpT0fRm+qEz6Fe
	 Z4yx67xPd2KBXNvgd+GN8edlzqwbX8L2+pH/7BfJ5ibt1K9xJB+QFh+mApWFQ81ACW
	 AbWx74erRxrvJTReaWz103zTebRb2he5A/wLAA2GDmhw39fVNUKgD56IljwqP9Jho+
	 FuIgIvCA5pOxyBxQpu8XxjxxZrcYeOuaaxaNjNyJKYAUV2Rm1J1oJXMMkWv5H1qWcJ
	 uu9hXEzCX64gg==
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com, 
 Mario.Limonciello@amd.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250218065924.917915-1-Vijendar.Mukunda@amd.com>
References: <20250218065924.917915-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] soundwire: amd: change the log level for command
 response log
Message-Id: <174063971678.346386.9561215750981668144.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 12:31:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 18 Feb 2025 12:29:24 +0530, Vijendar Mukunda wrote:
> Change log level for command response log to dev_dbg_ratelimited when
> command is ignored.
> 
> 

Applied, thanks!

[1/1] soundwire: amd: change the log level for command response log
      commit: be2f35e15939836d0e0115e99d8cd7a49b89cc8f

Best regards,
-- 
~Vinod



