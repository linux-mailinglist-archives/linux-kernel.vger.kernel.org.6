Return-Path: <linux-kernel+bounces-188385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A38CE15F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FCE2821AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DEA128814;
	Fri, 24 May 2024 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="BZb0NWqP"
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519812A151
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534664; cv=none; b=THKLEnmoH1gFAJFJ/SwzFxbABnBRNwcdzvf7by+TvntHuM7tl1kinMn+3IT+RNZf8FlfKbtyiIbkQEsVCirQYbHLoMBm+bHBVurBSOOb6Q4uiKQaxbkRbgxVkvW+LgHnkFkU+vMVZe/I7VzqWbp354V27U+vsOt4SBhomqg37XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534664; c=relaxed/simple;
	bh=lE2QS6lR1/Y/1hnhivmXubzt9g9a+xKOwCIxWr45d0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6zIjFNqLrv3cSzbskPRQhsLBauiwE0uQSr34R6LKcEG1blAg0PTAstYvVWtS6dt1H3bMRTNoNhwno5PBbM3b8WUR72ec89F0I+laxBQnxtUlruwAXK+uadEwIIOUJj7XTVAmCs926wauSCqCsmkK187ssMj8F04SFEkt48EYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=BZb0NWqP; arc=none smtp.client-ip=62.149.158.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([77.32.45.53])
	by Aruba Outgoing Smtp  with ESMTPSA
	id AP1rsMjiGwy3rAP1sszWGr; Fri, 24 May 2024 09:07:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1716534473; bh=lE2QS6lR1/Y/1hnhivmXubzt9g9a+xKOwCIxWr45d0I=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=BZb0NWqPJHs43h+FHyFkz6zJPlLj/BtboAoBuPOE0uHO7KjXRg4tsDRzIUb3sGwSS
	 lt/HjHUovGjrx2RfmTFrmTuEQ+PWZfHb/hSQyj3lAETbK3ZxyS9BMgYdzlDhuzn70U
	 ROtREzR9nqn3kG1E/CPnFzfv14iJp6XSQygBToA7HQR0is7f2vvSoEcpKNxn1SSZPI
	 iAbk3/ZTfl0VGcM1EWoqeFRLv+4lP1lApEnXP/ENH7RLBKNghhBT/1zXIRIZoO8f9x
	 /81UF4RR25NFQ2YDpTkgSC8XqU2MuyCvX4An81kXl4yffqpTu1R+szEkP7xcROyH5k
	 O3LxFu6aItzwQ==
Date: Fri, 24 May 2024 09:07:51 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	matteo.lisi@engicam.com, mirko.ardinghi@engicam.com
Subject: Re: [PATCH v8 0/3] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0 board
Message-ID: <ZlA8x9J0TBoRFbUb@engicam>
References: <20240429093116.9346-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429093116.9346-1-fabio.aiuto@engicam.com>
X-CMAE-Envelope: MS4xfCoxL4upyb62o7G9vEw+NpXZSx3bhoYjW0ZwXhTiw3qa4q6LGiXuZiFuOTdQPv9IaX1YLVA8vEQBHFNwJy3EOow3hcNH4ChqnVhILLw+XNfFNAMb62IG
 qgZiRKuBDca0Of3NdvDX+YHrKLrAx7YUDkeSoUZ2hio9N2Z8W4e9X1N5XXXoA09GDbydd8MUcQ13JaH+pkBEzAMVyBLvnzASPRY5BfzcoPvqekTdNNT1tSkQ
 RICQNahyzhe71x+mKTkSXXXV3zrzu+IcXmG0NJqxrv3aYFrCDrU+Z+meleZOjSOGMbkI8HmMqb2kOvbBPJBa0zx2caLNbYgDWZ1c12RiEYaiwUCJblpQN8In
 0SAHdV1oF5LFpbLQPLRIIxqfgYvfusdn6LoXNZ39nbbfdRaPRjOsGNiwOevRE3XkFTSZf8GR2OGxm9JeYru4DBoJYzlvWwgzsT947HY3/Aoc0Q9cCCw46gac
 fu4aJVkPyb3Mrf/UQYc0Taa0ozYhIBC3RXWs+AL7S3w9ouJfxYId25+XD4oKByadU4icU6VQheneqRh4JunEHE5nxmDCfDxjSxAf5A==

Hello all,

any news here?

kr,

fabio

Il Mon, Apr 29, 2024 at 11:31:13AM +0200, Fabio Aiuto ha scritto:
> Hello all,
> 
> this patchset adds support for i.Core MX93 EDIMM 2.0 Starter Kit,
> a SoM + Evaluation Board combination from Engicam.
> 
> The number of patch has diminished to 3, for I dropped the
> patch introducing a change in nxp,pca9450 binding which has
> been already submitted in regulator tree.
> 
> (Dropped also regulator tree maintainers as recipients for
> they aren't anymore involved in this patchset)
> 
> This patchset introduces just basic functionality for board.
> 
> Thanks in advance,
> 
> fabio
> ---
> v7 ---> v8:
> 	- fixed tag name in commit message
> v6 ---> v7:
>         - removed max-frequency property in wifi node
>         - removed pinctrl-{1,2} in usdhc3 node
> v5 ---> v6:
>         - added property in lpuart5 node
>         - removed unused sai1 node
> v4 ---> v5:
>         - done some property reorder, indentation fixes,
>           node rename, drop/add new-lines
>         - fixed line wrap in 2nd patch commit log
>         - added Reviewed-by tag
> v3 ---> v4:
>         - drop wl_reg_on regulator in favor of
>           mmc-pwrseq-simple
> v2 ---> v3:
>         - fixed dtschema warnings
>         - added Acked/Reviewed-by tags
>         - removed regulator-always-on on
>           bt_reg_on
>         - fixed clock rate assignment on
>           sgtl5000 node
>         - added wdog_b-warm-reset; property in pmic
>         - fixed indentation issue
> v1 ---> v2:
>         - dropped patch updating nxp,pca9450 binding
>         - fixed indentation issue
>         - fixed missing space issue
>         - improved naming of regulator nodes
>         - removed unneeded include
>         - fixed email recipients
> 
> Fabio Aiuto (3):
>   dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
>   arm64: dts: imx93: add Engicam i.Core MX93 SoM
>   arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   7 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx93-icore-mx93-edimm2.dts | 321 ++++++++++++++++++
>  .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 269 +++++++++++++++
>  4 files changed, 598 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
> 
> -- 
> 2.34.1
> 

