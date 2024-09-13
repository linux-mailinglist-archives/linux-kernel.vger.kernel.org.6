Return-Path: <linux-kernel+bounces-327822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4C9977B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965731C25CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA01D6C74;
	Fri, 13 Sep 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RK3++ilJ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="THQXwh+6"
Received: from a7-28.smtp-out.eu-west-1.amazonses.com (a7-28.smtp-out.eu-west-1.amazonses.com [54.240.7.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780861D6C4D;
	Fri, 13 Sep 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217524; cv=none; b=AX4RPjmTgSLTPipzwLiaJ7CdCtRBK6kOIYdM2vWdyhbmn3pnK0DzIJvcIcyvzWeYavJsiSIMVQ1Tw8eUlC58WqNt+iazD2jYby8LZvOPFkCFnkuqA0ExZ1UkdE4Nn8zSajx9b6mLi/0TIj+AORtRasamnvEsDhrTMPxBsGdfAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217524; c=relaxed/simple;
	bh=g6maka/lKgrwuWshcXJ3wPSbNiIvhMNMu/RgWlAcypo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJwWWfHgQ0gxD3VMR45k7SB0DdqF3k5y9xoAXcsX2nCegbpW7mDaw9fJt0+YWQEhRgDeGmeO/tF7rTHBwnN5OJZm3SP/2yn1Ukxlsj56mYdLH1DhZ1pbq5BMsfGbb9euA8E5G7wNd+oFFvM0lb73yxgo7EjJFG39vvUlH11e9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RK3++ilJ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=THQXwh+6; arc=none smtp.client-ip=54.240.7.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726217520;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=g6maka/lKgrwuWshcXJ3wPSbNiIvhMNMu/RgWlAcypo=;
	b=RK3++ilJRkktb3Wr4L+vRqVkPE0i2mP7JMHgexEXVVqPGcipm7/VG3tp+ZBJ9slK
	hASj1+/Hh7DyXBPQuqVrjfZRw+P8uLAoCht9KRozO+q5bvYnJfKRPrxPY2km0UNBe5D
	Gw4EiMotUftRE/f1GZfVP5S4WAXG+XRl34IlHe8nT1olyoFyBLssvJJA/R8hFLw65VU
	JRQNOnYd9CdS9KyHqMggJ9uRRhDCZUvrK/b2ljHlwhqw+SQqXYL7gYh+vQkbWLORBQk
	1d1X+dZuFiwqi6P/RXyexT0GcTijrn6WrMcAFvVADBbY+PTTfOntbB8sEFSd+pKoLNf
	0dY9KaS5Ag==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726217520;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=g6maka/lKgrwuWshcXJ3wPSbNiIvhMNMu/RgWlAcypo=;
	b=THQXwh+6Z1DNX7+fm/6JLN0tS3OeLvi8mSx02cnP4AT73FZmaK1N5sHvWIDmxcSm
	Jb3bmYPmYG4+JsYsmY0vHuxZKpmej8oQIoxi0EMhii60Ewhimhsuu8cfYohHKrGR+jR
	fOb2OUtNd7rEfmSa3YGqc8Rw5Sj6k0f/s1O13108=
Message-ID: <01020191ea950641-b277d24e-52ee-4699-a074-8604bbd09021-000000@eu-west-1.amazonses.com>
Date: Fri, 13 Sep 2024 08:52:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: dts: mediatek: Add MT8186 Ponyta
 Chromebooks
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>, 
	matthias.bgg@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, knoxchiou@google.com, hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240913031505.372868-1-cengjianeng@huaqin.corp-partner.google.com>
 <20240913031505.372868-3-cengjianeng@huaqin.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240913031505.372868-3-cengjianeng@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.13-54.240.7.28

Il 13/09/24 05:15, Jianeng Ceng ha scritto:
> MT8186 ponyta, known as huaqin custom label, is a

MT8186 Ponyta is a Huaqin board based on the Corsola board design with the
addition of (optional??) LTE connectivity through (usb? pcie? what?) integrated
module.

> MT8186 based laptop. It is based on the "corsola" design.
> It includes LTE, touchpad combinations.
> 
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>

After clarifying the commit description like suggested,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



