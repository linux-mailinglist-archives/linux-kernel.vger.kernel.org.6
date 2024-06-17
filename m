Return-Path: <linux-kernel+bounces-216642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3974690A28B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ADD1C21464
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68317179665;
	Mon, 17 Jun 2024 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="kr5b56C0"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44D176ABF;
	Mon, 17 Jun 2024 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591929; cv=none; b=PuU0tmJW6cuXVMzmjVNjl1t/KrpL1VVEh5GrOqOGqqQQGgbHEp1aZq4KDEbh8d8HNNM3Ts7DHYARGbj5kTHANA8VifKocGII/mmzcELP5/ncFtSV0yYuYnZZo2PNYWsYtPQDAYxClC0nwzw0uGmhVOHy+ifmd+Y61bBJhCFRBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591929; c=relaxed/simple;
	bh=+jeXfjlrGK5EVa6fxyWlB75AtU0t9OhFgX0NYh1Q870=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAv3tt1qRWy9MPAwiYFjJ9fmMPEPYZ3zjOr0b+nJ6f7L00MnxcxHRGYccyqDKEmhFE8rsBsM/yRP+XdZkrjXRKzeEPBh+tNModqUFBIPO8Ii9xQRYYlOVwLErXICvyu7+y5O6xlS3j1mnd+jgEm1przRGRRhaWp3ClS2GokkVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=kr5b56C0; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tS7StaUjtxem+KaMU9nNBhZvq1yvpGbzXt+J+yb06fA=;
	b=kr5b56C04Hd8AAmWfaIYCIoWigsmxVfURHfzk54CXbLbehMCO5ocny2qSv1zm8
	da0640tR68bw7fr4kkqk8Dy0F3V65EsA5PpL+PPsncFae2DHwD6R2+b2vnTjhFWr
	b7SugV+WU6jWuLfviNUUhAnsXRWnQy50fuZld+YrMh78U=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAD3X0SloW9mwmoMCA--.39487S3;
	Mon, 17 Jun 2024 10:38:30 +0800 (CST)
Date: Mon, 17 Jun 2024 10:38:29 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: layerscape: change thermal node name
Message-ID: <Zm+hpWKd0iokVvym@dragon>
References: <20240613222413.182662-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613222413.182662-1-Frank.Li@nxp.com>
X-CM-TRANSID:ClUQrAD3X0SloW9mwmoMCA--.39487S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUa7PEDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhABZVszYrukEQACs8

On Thu, Jun 13, 2024 at 06:24:12PM -0400, Frank Li wrote:
> Add thermal subfix for thermal node name to fix DTB_CHECK warning:
> 
>     thermal-zones: '...' do not match any of the regexes:
>     '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$'
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


