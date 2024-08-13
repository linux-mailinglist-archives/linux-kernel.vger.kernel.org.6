Return-Path: <linux-kernel+bounces-283998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA094FBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F63BB2201A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289114A84;
	Tue, 13 Aug 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="FKumcd9P"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D2814A82;
	Tue, 13 Aug 2024 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515329; cv=none; b=dY9cHYPyIPiuR+eaSZyUT8R0uy0JveLnpelugzJUpuwZdns7xxtms3pGRUgm0tVKKmdraYbH5dvva5yYdT/6R50Jg4ThgC4F3EQyhxLK/3ltfY7924MLm0SuE2XyEvuU9sZlD7zMmILfGjX6FRR0QLsvrBlLHKShZupAhMXWp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515329; c=relaxed/simple;
	bh=Pf5ZElkQmNA2m6aY8AbUjVYVSC9zVbF068LhSQLoXr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0PiuWwvwaurjIvowVpgxjtDmtRXHR5DsVSOJ/lFWeBNi+I1XlPVCYxluA3b8JjzMW3KnbmwmpqNnzJrqpq70NRz5DLt8tbvp0K7CpklBBV8lMfGZdznVb9cIdnU3bkT1IowKb84eWXqqZSfePg8w1vLBiVd0Hwcn8pFy/6TwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=FKumcd9P; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=oWH5Kdz5Je7Il8az5t2Br+k/4wua5bwNMFZMwTB36X4=;
	b=FKumcd9PEMy5CjqLJzuzMacub1nNOhjTrEekrHs0N3bGfDTBlu8+tgFpmENbd8
	rIEBmWAzC7JAuGOHfCnyoaUmYeTxr5ooMCKWKgKlgixj9B7qT+XswpEP6QSVWRwU
	gZUKxRraVzzmChMxdXBhSgy5QSQbwsXBQYQNOhAr52XQw=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3_w2Rwbpmk5UXAg--.8638S3;
	Tue, 13 Aug 2024 10:14:43 +0800 (CST)
Date: Tue, 13 Aug 2024 10:14:41 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: krzk+dt@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Ethernet
 Support
Message-ID: <ZrrBkaNZz9xFQK4G@dragon>
References: <20240725122522.5030-1-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725122522.5030-1-tarang.raval@siliconsignals.io>
X-CM-TRANSID:M88vCgD3_w2Rwbpmk5UXAg--.8638S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRs6ZWa6WIL-LAAAsY

On Thu, Jul 25, 2024 at 05:55:22PM +0530, Tarang Raval wrote:
> Add ethernet support for emtop imx8mm basboard

s/basboard/baseboard

Fixed it up and applied the patch, thanks!

Shawn

> 
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>


