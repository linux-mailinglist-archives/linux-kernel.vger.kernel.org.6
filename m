Return-Path: <linux-kernel+bounces-274761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B453F947C62
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E463A1C21DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F86213A265;
	Mon,  5 Aug 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI/UNlST"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB180C09;
	Mon,  5 Aug 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866508; cv=none; b=slRbGSc9b12lLWNo8YeOSVeDc1JYnoFqCh3dYlM6dZ2/i+PLpmlrCn1yR0Z0GMGYft353uAZT5EWpSoQ9INL3K+U/TcdqljoBI66e1X42H+y6UlcWLbhHDnaa5VvfBOvcT0NV2/Ys+Z5DHZNWBitY3VKH0pkuJvVIpvCDojfDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866508; c=relaxed/simple;
	bh=BfoqN7QidM/rp0pulyq5M6kPvpxbpQ+/CSdIbHdBDJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ccy22OG3vPliGW7GBlLvn9Ca/vezo18m0K+9WLzmXlGYoS5LAkvK6H5F6oiYcMwAehdDmqaMUcdbdn+Am3mhepKgnYlLeJrSkvYdrqlKG8WQ+mbCv/Ui+rdIdKOhEh3IsNp//GH81gNI2Rz4LL7vDvR0cOSeCCSIDH7f3RC3ncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI/UNlST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CD4C32782;
	Mon,  5 Aug 2024 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866507;
	bh=BfoqN7QidM/rp0pulyq5M6kPvpxbpQ+/CSdIbHdBDJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SI/UNlST5Tg7I5fdVrcWYpNtNcxUpq41a1OaCMz1kR4y4hvtzNpyfPqHadl0y6+Jo
	 IOjXShnj//r/igMqCNuhqWnzlnVuKUy2n3cAuiWRyPnCEDnndQrEpfzvcpdATux67P
	 kFYkka0Zk3wSJjeK6bn6BsiVjvQGZRrnwIgNexAmPIGjs8LXm2LSziIPQ8rdufvIcM
	 lqTDscL6dwwhALaTHkicm8RTLtQSk0VLdNaK3SJqs+iDu9UhhVdApnNJJ637vZNOZN
	 ihxbXRcclG21mvP4iE/IFpxzGovjCoD25dUp16agMF4w650qw3C9lDGY15IWSgrf4A
	 3vTt8Eu7193MQ==
Message-ID: <3dc5ecad-2381-46c1-8be0-888d56e892f5@kernel.org>
Date: Mon, 5 Aug 2024 17:01:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] arm64: dts: ti: k3-j7200: use J7200-specific USB
 compatible
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-11-8664bfb032ac@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240726-s2r-cdns-v5-11-8664bfb032ac@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/07/2024 21:17, Théo Lebrun wrote:
> On our platform, suspend-to-idle or suspend-to-RAM turn the controller
> off. This compatible triggers reset-on-resume behavior to reconfigure
> the hardware.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>

