Return-Path: <linux-kernel+bounces-437507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33979E9437
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CE218876F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55B0229B22;
	Mon,  9 Dec 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Di7ejoNy"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310EA228CB4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747561; cv=none; b=eg5yJxzKLHyk6Q6s46P4/xb2fgOBLq7c760D4fo9wHKdc518zZmXCYSi7qz3gYmCAT7a9LgWzvYDJmudTJO15Ic7e6HqmCrtIVZkgnbgASYgErueL3heqx4SOwz6GJZmn3DP5ZElEiVpB1C8j0LxMj5r0GbDY1RxNrD4gj9kSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747561; c=relaxed/simple;
	bh=locmv9bU7swIPpoywjbPDhPcbAaiqMU2Tsk33gzmpUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+i38H1pNtHARpdmOIzhqCu6JXa2rPc/0khxlFGcuENri/KwNDGZZHGloHr5t41ZXdSyQZPOhRZX/ssEZi2H523KuKE5b8a/pa5GrSXaNeal71A5QYlA+G2r6BOrVYlH9m7LRPNzzp5Xtt0xUyxDn7hD9fCVd0LHaOD9u/YesW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Di7ejoNy; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=a9t1ybfU0p7i8XBRjmbNqnf9Mds9LGg2edrrvPPWhKQ=;
	b=Di7ejoNyYcqLxWzulNQP0tYoJbO8C8F4kYu+FAb9NdrJmszrWuusAJLAP1Ja0Q
	YeNNLOvd/pGKQU6QW7mRe7EsBYggrE9a2701cmVYkXUcD+58w07hyAtNTegNJwNB
	H54wHZ8uKZble5GadJec1OzCtVq/e5MtZkyhfZe6YzC9c=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgB3vA0+41ZnRTaQBA--.47901S3;
	Mon, 09 Dec 2024 20:32:00 +0800 (CST)
Date: Mon, 9 Dec 2024 20:31:58 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: alice.guo@oss.nxp.com
Cc: alexander.stein@ew.tq-group.com, wahrenst@gmx.net, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
Subject: Re: [PATCH v6] soc: imx: Add SoC device register for i.MX9
Message-ID: <Z1bjPhQxV34bEZS4@dragon>
References: <20241118021716.396001-1-alice.guo@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118021716.396001-1-alice.guo@oss.nxp.com>
X-CM-TRANSID:Ms8vCgB3vA0+41ZnRTaQBA--.47901S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUslApUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEROwZWdW4JcK1gAAsN

On Mon, Nov 18, 2024 at 10:17:16AM +0800, alice.guo@oss.nxp.com wrote:
> From: "alice.guo" <alice.guo@nxp.com>
> 
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Applied, thanks!


