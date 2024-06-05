Return-Path: <linux-kernel+bounces-201697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3797B8FC1EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554381C23031
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA0A6CDB1;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEB1Ngso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0161FE9;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555232; cv=none; b=R5AzjapZFZY+Xs5/iTYTSKvQeJXFCpKX4mdj2eqkrl5+UE456xOzRMfzkNEChIET5KAtHMPyVA9vTjvlOjgOHf96xdP4jYSoX85wAccq6WIxnRXqOnGHhWDsEPkrs0aTR3ZmjmiM4WHqYk75ebaew4aBWHL+RFrsrbwsIWcu2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555232; c=relaxed/simple;
	bh=vSk+umpAj+GnvfHkPWWU0EmvuKasdlZ7VXKTMfwKlEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zhzh1oJAn4erhHbVT8EMh+mw1hgV29wpVt/M2ksVniMfav985pb2/U9QvD7XE2K1GpCOBxwQxTvaCFMQ10OXOEqfpdUp+MZ9A2gHg/WlXIpVSVlF+NKgiAXaPk0M+YqAZ7vPU4QDI9gO+xnSuv2g+ts5tUOijX9P7hAYWR+Q9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEB1Ngso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DC09C4AF08;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555231;
	bh=vSk+umpAj+GnvfHkPWWU0EmvuKasdlZ7VXKTMfwKlEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vEB1NgsoCBQtPC9HbWQtwpHSKSobrl1o54ZQvvd48vPmxMwMzPY0MTsSDV5yShAld
	 SBUicW0S1ELDeJ6Thd0LqAvJ1/eVtQNHG72xEDxKWo9hxeo0YIDYDc7ktOO90cC/IB
	 2PoUCrwe6Z/dHCx9iMRhdJAi/QgRXnKaZaDWRi87kzn/nmKt4kfYcgYYb8y/+2lAEy
	 ZeoFMEhtbz2iUwy15BORab8EbZ+odrVrfCsojmLceTIZVWNmL2A3iJc+EqRxPISrCl
	 950yNY4Sm5U3zsE3maqMFnAN79tN6axUg+sD64S/LD45CZMBzIF5JvOWpJ7Z50kOKL
	 uDChpbbu7nEiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B1C1DEFB91;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] platform/chrome: Add struct ec_response_get_next_event_v3
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171755523150.3149.10790669286594403851.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 02:40:31 +0000
References: <20240604230742.2878452-1-dnojiri@chromium.org>
In-Reply-To: <20240604230742.2878452-1-dnojiri@chromium.org>
To: Daisuke Nojiri <dnojiri@chromium.org>
Cc: bleung@chromium.org, groeck@chromium.org, rekanorman@chromium.org,
 hverkuil-cisco@xs4all.nl, tzungbi@chromium.org, gwendal@chromium.org,
 abhishekpandit@google.com, pholla@chromium.org, chingkang@chromium.org,
 lma@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue,  4 Jun 2024 16:07:29 -0700 you wrote:
> Add struct ec_response_get_next_event_v3 to upgrade
> EC_CMD_GET_NEXT_EVENT to version 3.
> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> Change-Id: I69ac374fd88c3d3ef294f8e81443a2fea588bbce
> ---
>  .../linux/platform_data/cros_ec_commands.h    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)

Here is the summary with links:
  - [1/3] platform/chrome: Add struct ec_response_get_next_event_v3
    https://git.kernel.org/chrome-platform/c/ba098ed9829c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



