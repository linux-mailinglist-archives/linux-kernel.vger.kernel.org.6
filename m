Return-Path: <linux-kernel+bounces-216669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932DA90A2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10AD1C21243
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A644217CA1D;
	Mon, 17 Jun 2024 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lthuXdck"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2F17BB18;
	Mon, 17 Jun 2024 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718594006; cv=none; b=eqfKEGwHt++dbpW2NKVksGoyp1xu0hH26KDCe4d4UJFGskivO7G+2Fpvu3bK1A+p9vQ/ct81t4TMo8qyAyPuB+DQwdN/6FZCqZ88x9qx1LTvCjjkWZkuLDMiZas+lcQ5vn9EZERYe5ON0O9bXARFP1EffZZOYWXZc7li8MTj9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718594006; c=relaxed/simple;
	bh=zj/fqqcObenxYpX0qz9FYtu/tltE0vWw6FSWiUkxYZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB7trMIZK+y2nmjNBP8Pl7Yq5NVzgC8CGYKuLhjuDzLPZGHmG6lAlhgEzECd3L+ZBViH/EI4koNMDxwkHnw5oB004Nr5pVN2pB8QRJ8DTfjNLY2K8ojRtCVsiiPhkLwg+B9YteL29uI1OMpeY344ffxXs9zQfRPXDNH/NGdvwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lthuXdck; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Elo/3F/DKvAhetW3CuNDbc+tEfHM8u7qL4S3xO4cKOU=;
	b=lthuXdckltaT6StJ2NUBkR1X6QTCPMJFxlsoVTrnCY7UgNFBhv+45ok6FY9OE6
	+ArWZ92Sne7E3CiNXx/6HX9bx/QZHqmLivc7jYuJndOo62WY20UBe/nxbV+zKz7G
	rC/xIuvCiXh9jDb+gLJQAKb7H69DWjB29KK43K8gKa6uI=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrAC3Hxm3qW9mycHOCA--.4193S3;
	Mon, 17 Jun 2024 11:12:56 +0800 (CST)
Date: Mon, 17 Jun 2024 11:12:55 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: arm: fsl: add i.MX93 9x9 QSB board
Message-ID: <Zm+pt+gg4I9YOp9Y@dragon>
References: <20240617031145.20057-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617031145.20057-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:C1UQrAC3Hxm3qW9mycHOCA--.4193S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIku4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQgBZVsVCpzaawABsB

On Mon, Jun 17, 2024 at 11:11:44AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add compatible string for i.MX93 9x9 Quick Start Board.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied both, thanks!


