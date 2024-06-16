Return-Path: <linux-kernel+bounces-216280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FED9909D7C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 14:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BC3B20E87
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A41118757B;
	Sun, 16 Jun 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VDJWUUvO"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD51181CE9;
	Sun, 16 Jun 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718540858; cv=none; b=eqRWzO827GV4GYjE4f0VoM88tfH1h8nCzBzD+FYRgHju35JuH763DDsk9yqK2LJfcLWBK5HOmprYplJk0Hk2sBoUHz5fXLIzKB7tFZvnGplgg3o/VQ/9yIab3aEv6tfdceEP0iJOotd/r03rTMtFZfyfkaDz+hqPc9R25OVaEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718540858; c=relaxed/simple;
	bh=Rku4kQR2R8ij5rFPCfIYq81uEOwa9vvd+DWNmhAe1Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlUHKQgEijbPNDj1Lax2+OBPc3tscK/LsFPJut4UQbs2OyEr/wfsgKgFgksQkqnB/CVPzF80xG24KPdodS5qm928VBM/4CJVjJVUBnRnHtgo+j+EUcZMC3fsK8CzseecVTpWHYNSL76Mluxtpp1UqoAOqtKMJ6kiYXz3Kuux6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VDJWUUvO; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=JnRMwwFkdoEc5/NCW6kftWAir30cVbQ0j2y/PvQ3WvM=;
	b=VDJWUUvO8q6Wy3ZDQ/po1/sppVWySiCJqpCFFPsrRIuzxaF3gZ5dRKu2wza3qZ
	dd8K93C7eVedoZnKRLihFPPpD0NO0SnINDCpkjngrGQqoP7wiHb0+H2ZUs2vsVyB
	wOkOtINMFYJWN/hvGSVCc90wkuvkf8yHptG5deXyZSWEs=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrADnL2kT2m5mUY7ECA--.11632S3;
	Sun, 16 Jun 2024 20:27:00 +0800 (CST)
Date: Sun, 16 Jun 2024 20:26:59 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: Drop Li Yang as maintainer for all
 bindings
Message-ID: <Zm7aE5+1KONVCi1i@dragon>
References: <20240604142249.1957762-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604142249.1957762-1-mwalle@kernel.org>
X-CM-TRANSID:C1UQrADnL2kT2m5mUY7ECA--.11632S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVwIDUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDRQAZVszXmJAYgAAsK

On Tue, Jun 04, 2024 at 04:22:48PM +0200, Michael Walle wrote:
> Remove Li Yang from all device tree bindings because mails to this
> address are bouncing.
> 
> Commit fbdd90334a62 ("MAINTAINERS: Drop Li Yang as their email address
> stopped working") already removed the entry from the MAINTAINERS but
> didn't address all the in-file entries of the device tree bindings.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Applied both, thanks!


