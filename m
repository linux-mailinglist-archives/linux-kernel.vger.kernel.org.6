Return-Path: <linux-kernel+bounces-271718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AAC945283
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADD31C22FF3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74130143897;
	Thu,  1 Aug 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="fn7RUN8W"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950A182D8;
	Thu,  1 Aug 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535478; cv=none; b=MXXUtokZGx1yh7Oxkq13KcWouxOsb726VR5q5T1Ha3Zvg12BOG8bpOic70EyY6qM29pbGtG8CdxYUCIRsFPdnURW3AiE7EwXks/uF3gvnMDeiSqC/nCIcAW67aR9W2m56ZWfP+y6UM7MC3vwh05Ycuf8+gu9zQFRmQB8S6g11vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535478; c=relaxed/simple;
	bh=S8SOjPDnVl4S4IZS+WyLCAPdAOuYOZjE2Y+Wj+Q++cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTgUD02WIL5NI3OzUo2rli9q2kdAUWEZuOlaGkCmnAfbICLuTYL+jdYBx7d+7UbZqRHUqfmdhDPAHBtNtuVaynTHVb45xxX1kz0QldMQkgtEma0ouWAOYkVTj7H+Xvye2tQxt9/MGH6qlutizf/aN7jardzBWnYJP3/lbpYXU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=fn7RUN8W; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id 504BE40460CC; Thu,  1 Aug 2024 17:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su 504BE40460CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1722535087;
	bh=S8SOjPDnVl4S4IZS+WyLCAPdAOuYOZjE2Y+Wj+Q++cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fn7RUN8W37Hny2b6u76N3fbEnKUjH58VQndE1TMCMrguwC4RUXin9vaNKP+JwY3Be
	 cGumPMHmjO37yUiVufBr5tLYgjAAKoIBt032I4uBooFQKcIthwYRWx5dM90z4j1pCJ
	 D59Fwf/nWQZ/ljND40iOJHz52rVb0cwFThrqdEocZauLFsdreJZSWBTO4IyfwZFK9i
	 RPWggfKXYphV3OG6HWSFRrcUiCvCJ/vSzYPWS1stpAXKPcO81+f+SbpKWG/zuIwmf3
	 BVkwh76feFNZnzBoTjJO8mOKTwt99KJDHwobdvVkX7Kxphlthw18QluGpBA35VQa+c
	 yx01ng+MuUdtA==
From: Sergey Bostandzhyan <jin@mediatomb.cc>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Bostandzhyan <jin@mediatomb.cc>
Subject: [PATCH V2 0/2 RESEND] Add DTS for NanoPi R2S Plus
Date: Thu,  1 Aug 2024 17:57:34 +0000
Message-Id: <20240801175736.16591-1-jin@mediatomb.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

as requested, I am resending the patch series, now with hopefully all
relevant addresses on To/Cc.

I noticed, that a DTS for the R2S Plus is not yet available, while the
R2S is already there. The only difference is, that the Plus version has an
eMMC, so we can reuse the R2S definitions and only add an eMMC block, which
I copied from the DTS in the friendlyarm/uboot-rockchip repo.

I applied the same DTS changes to u-boot and tested u-boot 2024.04 with
kernel 6.6.35 on an R2S Plus which I have here and the eMMC became visible
and usable.

Kind regards,
Sergey


Sergey Bostandzhyan (2):
  arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus
  dt-bindings: arm: rockchip: Add NanoPi R2S Plus

 .../devicetree/bindings/arm/rockchip.yaml     |  1 +
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 31 +++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts

-- 
2.20.1


