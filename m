Return-Path: <linux-kernel+bounces-225377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216EC912FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E3B1C212D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF317CA13;
	Fri, 21 Jun 2024 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C5Jjm4yj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57217C7BD;
	Fri, 21 Jun 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007106; cv=none; b=acztoAs2IOSCrLy5833Ug90Mn3HebEukIut4cgZxbsFmuoWxY3dp1x0lWiKsT8UZZAuG6Nsum1WZCQv20DNmUjbeArWMmrCA/bk1Ekl9uBNmxG6siDx6B7hYnqnTCXbgumoiXzbA985VxKfSQZwqzGJqpcH3ofvnUoExjzi1gLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007106; c=relaxed/simple;
	bh=Bnakr+xsYVt2dVEvRUkd/iAxPi1ydgRoDjlbtuDkEg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMCCZG0rQFUd+vh/wRsr4niBhGNUY+Xa2CEGUiYmM+6T2eDsla/KvjMXpfjpR6kUHNfMiAbmImqvz630dt2I/wTikyDBqlWWfYSKzeMEBJ+N26tchnzo6qGKmH5saBTYvcpSdIfG5N7VbZ9NYrrcTyi9o/pkBFRfpw/fJuR3alE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C5Jjm4yj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719007097;
	bh=Bnakr+xsYVt2dVEvRUkd/iAxPi1ydgRoDjlbtuDkEg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C5Jjm4yj8+riKaj2jNVf1rS5Q5ggPfKxFEYnkhXi1WYqwqV518Ddgdzq1+7GBTgp6
	 DOiDI+XXaaEmw5Id83w84PnMpMRYq7fvlbXK0vNoZOtuWSZrsaQ1jxtY0WyvKHMCaO
	 j9bbO1Ab0HtFN8bzc2aplmUf5QBPCps7jxopivH8SQvoupfuDQ7ovE1+dz11RuN8MZ
	 mkywGw4JZcFaVTuTM4CHdAgWPmCisyRgnxKQk83fG5R6f5wycovIkZqQuBSScnbl9A
	 UaAlsDbTNsM66ZKmxCLmhKSh9KjJVyG18fm+qD2SEQ5MEmUeaGSosW3pEXtjSlHQCO
	 KnCv4N5Z1NCrg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F22A037821E5;
	Fri, 21 Jun 2024 21:58:16 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 22 Jun 2024 00:57:20 +0300
Subject: [PATCH v2 3/5] arm64: dts: rockchip: Drop invalid
 mic-in-differential on rk3568-rock-3a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-rk809-fixes-v2-3-c0db420d3639@collabora.com>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
In-Reply-To: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
X-Mailer: b4 0.14.0

The 'mic-in-differential' DT property supported by the RK809/RK817 audio
codec driver is actually valid if prefixed with 'rockchip,':

  DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
  rk3568-rock-3a.dtb: pmic@20: codec: 'mic-in-differential' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

However, the board doesn't make use of differential signaling, hence
drop the incorrect property and the now unnecessary 'codec' node.

Fixes: 22a442e6586c ("arm64: dts: rockchip: add basic dts for the radxa rock3 model a")
Reported-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index ebdedea15ad1..59f1403b4fa5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -531,10 +531,6 @@ regulator-state-mem {
 				};
 			};
 		};
-
-		codec {
-			mic-in-differential;
-		};
 	};
 };
 

-- 
2.45.2


