Return-Path: <linux-kernel+bounces-201698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62238FC1EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DC0286066
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C227345C;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV2I7aXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22261FFE;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555232; cv=none; b=uQNCRyq1uvJENpxaPbfEHBEQwsYLDsNTKnor8bjLmx4gW72W5e41DAW+4DKcDs2K9gaXTYINf/lUfxF0Q76cWlltqRAI+k9GDW1nSJv/sgo7BQ8Md3iwy/poUWn74FPBHkh9S1n/IpQQtjaMPC6FuDSeAkcIDDoRgV0vRAz/2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555232; c=relaxed/simple;
	bh=ScFLDPbQl8TSKcjWLoWFCNH7yaUUfxLQ3FXYwb8F5lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MPBdDzV8B1CC0AUOMerblDE874vj++nWwb0RYd4chxHEqrtxE4AMZsmyhsM5TeLSd1FQbqWHySJpq2l2QHcStmjdzTKg8Y7otNziD9ZE9b7++jSZ/8pu1Bv7FMj5ejdNOWsCqdUJpzSgwI26eWYeJPYmvCAsvx7JYrnXOwt3rpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV2I7aXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17F72C4AF0C;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555232;
	bh=ScFLDPbQl8TSKcjWLoWFCNH7yaUUfxLQ3FXYwb8F5lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cV2I7aXLGiqh8To4mwHWIqymxFqGY+dcqxIG1eMLXcthW1Zskm+v9Pz1eMt6Yf3Df
	 3bXEJd6qE13wNPKvMJMoXAg6YXqOesd+N0TebR4Zp2CElzbHOiuMjzYE0yL2LpddEH
	 3BiYKHTpU3Nw7waW9yHXuwnCsM7FJ+C/eREpIcFzqbC3lSGOGWchKJUr9LgmKqBxe1
	 3dHF1ZYUOtDZH0qdccxP3vTBlTmkHssoRnmHS1IA/A3ArClL6yIu4AFtVzRKv4gFLJ
	 DTXKjukiV7wRMyIcSOWw+fZ/mZIsItPZaV2O3iGoyqQzy3uu/Rsi4kW5nCFJgnn/88
	 OG1O6312e2U2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A11FDEFB91;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
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
 <171755523203.3149.11797786419541321356.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 02:40:32 +0000
References: <20240604230742.2878452-1-dnojiri@chromium.org>
In-Reply-To: <20240604230742.2878452-1-dnojiri@chromium.org>
To: Daisuke Nojiri <dnojiri@chromium.org>
Cc: bleung@chromium.org, groeck@chromium.org, rekanorman@chromium.org,
 hverkuil-cisco@xs4all.nl, tzungbi@chromium.org, gwendal@chromium.org,
 abhishekpandit@google.com, pholla@chromium.org, chingkang@chromium.org,
 lma@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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



