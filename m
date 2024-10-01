Return-Path: <linux-kernel+bounces-345775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8998BAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD571C23452
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC961BF81A;
	Tue,  1 Oct 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LDe1RSQT"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A61BF805;
	Tue,  1 Oct 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782023; cv=none; b=c9b/hfzAJbujeTZxtAvTZ3ASIkW+eFILOMcmAUNxk4Q+1H7YXZR1cwWhy1k6K8cZEjhkqheb08yj7Wa48YWBu6fjuuROR8kqiUB/Js9aizUc6zqHQRM2Ba8XuJhiybXVwUMVd6/i7dGJ4mQIGWoXUahUqbA2/jCShsboR3f8rjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782023; c=relaxed/simple;
	bh=xEUxcuofVqD9wWT6Rn/0Or9UbqqBK0vbX1VkyuD7YpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYgfBhzlMGJ6p8w9DRI2tQHnRpCFFVHJ6LRX1i404y/S0aeBOxlfeCODwKh2xrK6WimyqgJdoYkXQKNWyXILJxYWl1A4gipzUmRYj/GiNdkDAF2bxSYEYXCjw3vVKxP+ErMIzlBgNJ83asQ7Ct/VhGSdi4bR5m1SLGRmhmRGr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LDe1RSQT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C394C20347;
	Tue,  1 Oct 2024 13:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727782010;
	bh=Fgu77PRRzytQUIA2WUNU7g2WxK+xwIRy8YMbWMyv1RA=; h=From:To:Subject;
	b=LDe1RSQTtDaAIutpaxulrtQu9un7DLpIBgWE1c0Cv5G4wdkIjTtWRFpBQO9EP2mqf
	 RY5UbwL4tgiVfLJ/QlvznFjVPJVeXKEhMeF2QCPsuckGtAv6fM6E8F3e8nuBP7ygUk
	 2UnXYZWJiawNH98qd/HgEgF84xIVT4iMh1y2FK9YCGEDBLXEYcTygUZMwG2GTkEJeX
	 eQpJ9o7BRL9WrH3QTtLou+HxNC/kgMRZ4K2UPif9CFM2TuHddCdy83gK1Clo82WQzP
	 H9O8/G0SuFq1xyN2iBCyZqhNbJBOBM5pAipzicjkAMmppZdlOBEhpcfKGuAvAiMUQ3
	 GFMr7TMctE0Xw==
Date: Tue, 1 Oct 2024 13:26:45 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Update tla2024 adc
 compatible
Message-ID: <20241001112645.GA29051@francesco-nb>
References: <20241001111413.10390-1-jpaulo.silvagoncalves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001111413.10390-1-jpaulo.silvagoncalves@gmail.com>

On Tue, Oct 01, 2024 at 08:14:13AM -0300, João Paulo Gonçalves wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> With commit f1c9ce0ced2d ("iio: adc: ti-ads1015: Add TLA2024 support") a
> new compatible was introduced for TLA2024 ADC. Update the device
> tree to use the correct compatible for the Verdin-AM62 hardware.
> 
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>



