Return-Path: <linux-kernel+bounces-215990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DFC9099A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7A32829F9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120D461FCA;
	Sat, 15 Jun 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di9FlrJk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DA4437;
	Sat, 15 Jun 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718477555; cv=none; b=ruQ85XH8zpVV052EHcUVpsvSVcAoFTMs8uZUNVzsxgDXDe/EAS3x0ENtBv7chncBEA/jTwtEtOZQjeuGBanqDl6nu5DWYn653Adf8IupDC7AMY5yKKuo6VEy48vJOXSDkT6E5hJRA76+5qcIORZX5tF5qHU5ysdqAk+ZEiQfmb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718477555; c=relaxed/simple;
	bh=nyGltL8ICDC6yNzr7LgN5jIYezIhu7MymJF2gKvIdTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QSokFffiZ9xRDHpIGqZUT2QNs53asz1s7V7JKMgEt+o3PopK5kGVvQbx8Go1oYV8lvFzfmjxA3svlZVqCzXZOaaVK2fkkA8ZtPymfwem/0tvUE+MiCtCsvM5tktYMxv2LCmROTAxKjiWZ9LefpsmlixUzs3Fs7OsTiHhpACCp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di9FlrJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72993C116B1;
	Sat, 15 Jun 2024 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718477554;
	bh=nyGltL8ICDC6yNzr7LgN5jIYezIhu7MymJF2gKvIdTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=di9FlrJkf6enPrwrRLzCVdp15Vg/c15nzBD5yNkikm4q+vtua7GROqMrDs98lCB1v
	 S3G1LZDtTNPw1fp6RdoLCzPO4wdz/D+TUWVQfcCxCmNfmR8wAJsvW2YbKY34vlFqAd
	 WrYLGIDJo3IgoYKMPj0f2CHcY951iIOWPwvK6grdff2BT54uOVyinA9fSjE9I59QPr
	 IBzE12jWaiQIg2PHpHaa/UHcz9IdCwiVwDHydjnAhRrYUchx6WnYtkZgQZkwD/hG+9
	 j/G2OJMSWYaOae4mNPLfHzskx7BzHL6IvyG8I/YXRpDzON4GCG66/mU+yYTm73PTlc
	 oqtWJ4SkTdk9g==
From: Vinod Koul <vkoul@kernel.org>
To: conor@kernel.org, kishon@kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, frank.li@nxp.com, conor+dt@kernel.org, 
 Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, imx@lists.linux.dev
In-Reply-To: <1716962565-2084-1-git-send-email-hongxing.zhu@nxp.com>
References: <1716962565-2084-1-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v7 0/2] Add i.MX8Q HSIO PHY support
Message-Id: <171847755003.716119.4761960505484541660.b4-ty@kernel.org>
Date: Sun, 16 Jun 2024 00:22:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 29 May 2024 14:02:43 +0800, Richard Zhu wrote:
> v7 changes:
> Rebase to 6.10-rc1
> 
> dt-binding
> - To keep the table format, add "|" to description of "fsl,hsio-cfg" property.
> - Refine the contents of "fsl,hsio-cfg" property.
> - Add Reviewed-by: Conor Dooley <conor.dooley@microchip.com> tag.
> PHY driver
> - Use "imx8qm_hsio_drvdata" as imx_hsio_drvdata struct name of i.MX8QM
> - Remove redundant memset().
> - Add Reviewed-by: Frank Li <Frank.Li@nxp.com> tag.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
      commit: 7c46101aa631843ded626b823b5a412d57371812
[2/2] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support
      commit: 82c56b6dd24fcdf811f2b47b72e5585c8a79b685

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


