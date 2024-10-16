Return-Path: <linux-kernel+bounces-367213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D374499FFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB91F22AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC34186287;
	Wed, 16 Oct 2024 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KmcmHrrG"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435815C147;
	Wed, 16 Oct 2024 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051182; cv=none; b=p2QKsQQyJIjnTjYYP/zg3weL4SkDLIkiZI1hO8ijpyUWc2vWwm2z3UeOMXwriW9r9kZso/slSBxjGPklzUQxYHqX1Pw/E3X8a5lAxmJTCNxIuNnujiNfpOg/1vhgNDzJfWz/xZFexm7Py1kLzlkUK4139IXLdstKFBLohkOyHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051182; c=relaxed/simple;
	bh=5rl7VH8L6iLNEFrhwYrW8yXL9lh5vJIeeQzAcZKsO0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ+trjNvXoJZ3ICwH5p7CVgdwOpaXU3AoBHJnCFFvdmDahT7ktIfvyFPzoc4rrSq/bC+TS08yZGEyN7qa3ItYyBKUibNqBPagkscguoQttAVJSUJy1lI6ujoe6OinIB5atN02eItNevsz+587rRGH6+VQjAZG8WfnKhVogkGKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KmcmHrrG; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5y5oqftq+ocfRHFauntiQYUuSJ9+uX2eH92sTX83kBk=;
	b=KmcmHrrGjNgTu+rSi8f8ANr694w64EVxsPtZUSPzVR1g9nH0K3W8j1nxPJToZE
	v8jG0NBJJpLIFxUGVTcd8Ksu5KyzdnisjyGgiMLOKj/lENx9SBb44Y6tkNE9m38D
	yC3LmjxgfAnIF12ZCV+yzw8gOQVzazHJDK0pYsflgPxgI=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnaNyQNw9n3dMVAA--.274S3;
	Wed, 16 Oct 2024 11:48:34 +0800 (CST)
Date: Wed, 16 Oct 2024 11:48:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Carlos Song <carlos.song@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	frank.li@nxp.com
Subject: Re: [PATCH] arm64: dts: imx93-11x11-evk: remove redundant "sleep"
 pinctrl in lpi2c2 node
Message-ID: <Zw83kAFABugIDiPY@dragon>
References: <20240903093911.3235306-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903093911.3235306-1-carlos.song@nxp.com>
X-CM-TRANSID:Ms8vCgDnaNyQNw9n3dMVAA--.274S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEg96ZWcPEZ+K8QAAsf

On Tue, Sep 03, 2024 at 05:39:11PM +0800, Carlos Song wrote:
> In lpi2c2 node, default pinctrl and sleep pinctrl have the same value.
> So "sleep" pinctrl is redundant and remove it.
> 
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

Applied, thanks!


