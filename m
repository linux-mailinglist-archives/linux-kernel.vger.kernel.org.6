Return-Path: <linux-kernel+bounces-436951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9C89E8D00
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3F281D51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21E5215198;
	Mon,  9 Dec 2024 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Hfayqua+"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B0215188;
	Mon,  9 Dec 2024 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731481; cv=none; b=TFGd42qfVmGhe/1YJwbFXVElqU972JZN/IDx34qYoy6aGkJyLWbi9gtRBJz+tCSFpha7yxLbrfibuXWrEq6fWdFw5EgCfWqOwn3jc5KjMsPwdAAyJ+L3Z0MJ+CMplYNSr4Fn1ZwA0V0HwNVvLge1TPK9n5frHlx5+OSPD6Ohc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731481; c=relaxed/simple;
	bh=/7H40Njj3gf7vZrVb7miUhyDm6kTIHd1JIEUnPm70+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vhw+Mf0vEgk2Ifq3BoYGGsxD6wLmR5RuyV+Um2R8QIqhCIZFOogLqEaCkQlgy6TYGPjw4jZMh+i58lRmgI9URkPlADRFrMP1Wifej3Av2nwduom9A2ILxQ6rrjpkrd9J5XG756kcD/bhwvgfMYuphpYabpcs/X3lecl5G38oFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Hfayqua+; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=DFeocjNOUdIRJAXa/Rnba2ub2M7xywjcZC0gF4rAoMk=;
	b=Hfayqua+CSqQlibYs6L8LzVaOkTNskyTk/hsL30DQNAY+UdzhKUb6IA9KyfpaV
	YrOXfh6CNUcVk6Kd9nM7/eMj9INb1NO0QoObb/JG8m248rS5u9vHcgW0VT7uZu75
	JPl3/pU5w0RFqF8w7O19h1wefCwXuC/0l/udP2qdJnIkM=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAnpl1CnVZnpINvBA--.46282S3;
	Mon, 09 Dec 2024 15:33:24 +0800 (CST)
Date: Mon, 9 Dec 2024 15:33:22 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mq-zii-ultra: remove #address-cells
 of eeprom@a4
Message-ID: <Z1adQsiNfYMuVgp+@dragon>
References: <20241018183117.740439-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018183117.740439-1-Frank.Li@nxp.com>
X-CM-TRANSID:M88vCgAnpl1CnVZnpINvBA--.46282S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4Xo2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRWwZWdWeNqafwAAs-

On Fri, Oct 18, 2024 at 02:31:16PM -0400, Frank Li wrote:
> Remove #address-cells and #size-cells of eeprom@a4 because no children
> nodes under eeprom@a4.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


