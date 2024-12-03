Return-Path: <linux-kernel+bounces-429207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431DB9E18BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4B016633B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8891E0B7F;
	Tue,  3 Dec 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="l/DikrR2"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C513D890;
	Tue,  3 Dec 2024 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220241; cv=none; b=JpZf4h9JPqNde2BPYW8IoJVIIH8KZtA4YJOBI6khTx8BquCmGnGUIsBa3S3t3lApxK9n+ehau/v9ZiCkR3L1cr9QFh4HgBP3EgPii0I0d2oMEqAo0S558L/UFWS5LKloGyT6XHsdcZ8r1BiqiexGyhSA2gllZCzfApMqtisMPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220241; c=relaxed/simple;
	bh=mhTUSRwUM837GXOkz/9K0j4JT62ehvlcu7rqHOvmhBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU4PkREtDHZ34K0Buo5OWH+XZHM3D4WJNr6vhxcvfSYQ6rWXoECRjE0f+U5Esiut/uOPgT9XZbxxGAHzg+6gYT5OfrL57l3ifgOLUlK9KbSyaR/vlv6e0IvfVmB7D0iKo5o7y5Td0yTrpAGZrMzfP74W3S3znxbTrUc5HLDxcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=l/DikrR2; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [192.168.1.107] (87-97-106-140.pool.digikabel.hu [87.97.106.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9565E88E6B;
	Tue,  3 Dec 2024 11:03:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733220233;
	bh=HokNuuQzeMkWB9URPxvGeb03vo8XymEkhKykn+Jl2dI=;
	h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
	b=l/DikrR2H16CyHIB2zaOEkPdN4a4ujradnztGYdXKfXkaYMpw27NCBjk8YKoyjgS+
	 slUP5zUIn3vLGoDsLO7JbFSxB0hh2t3XJ22/6i8AMVrP8uxFWL/I0S1ouZNv+ftx0K
	 wjoNWsBURNe5/rJyaKDTPhpUVKZQTN0qZYrwSFk8CJQkZOhBd/ivKVSRj7PZym+Uhj
	 k0ZVMxJB/3Y3LhaUEiIJntUvVq1HCOIq3Wp1MGBi0h3DZHef9+/+iB5AMZKXyZVYuI
	 +mzQqSQfLTqpQmRfeVJKDj/drkEfRGO551k4Py352i91Gm+T7WfKKYwecj00/ftWIv
	 QaiDFhq+n58Ug==
Message-ID: <983c09be-232a-c770-59b2-98859ae60e6c@denx.de>
Date: Tue, 3 Dec 2024 11:01:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] mtd: mchp48l640: add support for Fujitsu
 MB85RS128TY FRAM
Content-Language: en-US
To: Jonas Rebmann <jre@pengutronix.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, David Jander <david@protonic.nl>,
 kernel@pengutronix.de
References: <20241203-mb85rs128ty-v2-0-42df3e7ff147@pengutronix.de>
 <20241203-mb85rs128ty-v2-3-42df3e7ff147@pengutronix.de>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241203-mb85rs128ty-v2-3-42df3e7ff147@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Jonas,

On 03.12.24 10:37, Jonas Rebmann wrote:
> From: David Jander <david@protonic.nl>
> 
> The Fujitsu FRAM chips use the same command set as Microchip EERAM.
> The only differences are that the Fujitsu FRAM chips don't really have a
> page size limit, nor do they automatically reset the WEL bit.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>   drivers/mtd/devices/mchp48l640.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

