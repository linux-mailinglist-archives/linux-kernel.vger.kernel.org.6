Return-Path: <linux-kernel+bounces-396699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E869BD0C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A48E1F23424
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A31714A0B8;
	Tue,  5 Nov 2024 15:39:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F37346D;
	Tue,  5 Nov 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821188; cv=none; b=bx733OOVcnobojOzvFlNZGUDQJUqe9Emx0CvVXpdKu1rIlETuEDaF0VWZLF6sqywgcg0++zIlIOShGMdKIPYB4E7g2ehN8XYvf6pRTuU6aDddRES/FFliImb3n3J3ycgMo70wFSFKnWAXOvCr2NZeryUq0jbiWknc/CVQJnIzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821188; c=relaxed/simple;
	bh=JQgpECDI3jzMgfkPGMbImjv5lpQBZcsgSTAJPUw6Myg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hcEkuXhC/RDAskvx9GhCz1m5QA37QbamaZZnSnB6e6wdSFoc/Jm7a3hB1VI5z+1iZ/gJKbvJunMW9DdazrypksoN72Y+bOf7ifUIfmIV8QdCRoRbABomBGHKiGp+n090gV7W4fyUwbV7cYP23SDdgn4Nghw/T+QmULGAoQGVPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A0C4CECF;
	Tue,  5 Nov 2024 15:39:48 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 8CBC25F8BA;
	Tue,  5 Nov 2024 23:39:45 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Andre Przywara <andre.przywara@arm.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Alexandre TORGUE <alexandre.torgue@st.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Tony Lindgren <tony@atomide.com>, 
 Shawn Guo <shawnguo@kernel.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20241104230628.3736186-1-csokas.bence@prolan.hu>
References: <20241104230628.3736186-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH] ARM: dts: allwinner: Remove accidental suniv
 duplicates
Message-Id: <173082118554.1463380.5508930595133568023.b4-ty@csie.org>
Date: Tue, 05 Nov 2024 23:39:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Tue, 05 Nov 2024 00:06:27 +0100, Csókás, Bence wrote:
> Allwinner suniv boards' DT files were accidentally duplicated
> in the Makefile when they were moved to the new directory
> structure. Remove these duplicates for code cleanness.
> 
> 

Applied to dt-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/1] ARM: dts: allwinner: Remove accidental suniv duplicates
      commit: bd4215c71992d89ab84339aab56bd8574134708f

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


