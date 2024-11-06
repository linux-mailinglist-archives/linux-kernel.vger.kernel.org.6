Return-Path: <linux-kernel+bounces-398766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E59BF5B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060111C21401
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C620C02A;
	Wed,  6 Nov 2024 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Zhtz1ZjV"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A3204F72;
	Wed,  6 Nov 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918997; cv=none; b=odtYa+gRDMosDofBujy3ddcRq4XQ7EjBX1oYPi0hL2P6ps+9Zt1HO4MCELdZv9vl1740VrKxN309VYfuTs682vMVbiM8+bTxSrkTDmqVrpaTvpSFLTP9knG+LuK02uT8zWsuU9pMmVwAk38/goZkOmUaht4dZPq65igeGemecIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918997; c=relaxed/simple;
	bh=li6C8f3t3SYbgMpO/kXts/p8GR96Pv4j3k0vjuIusI8=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=KomkemxVhlUjFjmUBJzmHIEgvmwr7no/gYpXze5zhHHxdb/7/tCHgwjG2C5tTLFRqU+81qz8B5JcN8Nw8gJJm2EZzmXLCIMguRIwpFewAUhPLpQp4qBR7jZi2ZaITB7PPwqUD0DyBnESyPcnNslNfsvQgprnhWFeCW7Cnc8jbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Zhtz1ZjV; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1730918976; x=1731523776; i=frank-w@public-files.de;
	bh=li6C8f3t3SYbgMpO/kXts/p8GR96Pv4j3k0vjuIusI8=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zhtz1ZjVOmW/RaDQV1THforkPHmN56+jsPkuY3IO1PPsj/x9Q4EUztT+4gSGdPlN
	 pxX3XQpdtgF8z0wKMxWd4/I4oJP2h5GWmzRvrjHF31uxkQJwHJubWH3gP5fKsl2d+
	 IeFUhPdNC7Fjk/0hQjCeOsKy3QpZsmxcvjPEEYOAA05dbHyr0MvDv/CgnqyH/+qQl
	 zMgoBWtQlNKg+OUmDT9rVWWo7rHMCTPBTlWPl1q2x4AGut2QE4hALIaj2Io1Rmbjd
	 j5PQfJZLqx9MzxcACE8upxBzeJjEHgDevlO3iclRpceERarm1IKOZRCya7kN6rOJD
	 UtJ/AxWNeLjtq0Fwow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.145.66] ([217.61.145.66]) by
 trinity-msg-rest-gmx-gmx-live-c75c5fb4b-p29nc (via HTTP); Wed, 6 Nov 2024
 18:49:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-ef654aa8-f10a-4195-82c8-65b3ea654c7b-1730918975868@trinity-msg-rest-gmx-gmx-live-c75c5fb4b-p29nc>
From: frank-w@public-files.de
To: angelogioacchino.delregno@collabora.com, robh+dt@kernel.org,
 matthias.bgg@gmail.com
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, daniel@makrotopia.org, linux@fw-web.de,
 leith@bade.nz
Subject: Aw: Re: Aw: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs with
 applied overlays for bpi-r3
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAPDEroWUeR3iUFnjVr6WFLg3=dkML+5cbRPph9bj64F=zc1UWA@mail.gmail.com>
Importance: normal
References: <20240608080530.9436-1-linux@fw-web.de>
 <20240608080530.9436-2-linux@fw-web.de>
 <trinity-82c94d49-2a78-4470-83cd-3c6747e01849-1719434738199@3c-app-gmx-bs52>
 <726f2ed3-675f-45e8-94f0-d392181e7f92@collabora.com>
 <951E802C-1B53-45C4-B3E6-4A3400F47214@public-files.de>
 <CAPDEroWUeR3iUFnjVr6WFLg3=dkML+5cbRPph9bj64F=zc1UWA@mail.gmail.com>
Date: Wed, 6 Nov 2024 18:49:35 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:04HA3rCBFobkKgyJv3PRzaWDTdIiPv8aXPTy1/iJeSgOHSEJUK9hCVHSD0wn2SSqhizMD
 BevU1VpOn8iWFu/s07qAKuNevpeLaJKGWlDCyOby34HfK6pyfLyeR2LuHLLwv1u3hD14BDfsaTQ7
 kcgvrKBmvIignRFMW2hYJ0/V+ejxxM7rUvgx0uWEWJ1J7EYsmMiDtxAguxMXnlwE+0Hwp7rKP1DH
 brAeezdmDRhJwcVWEjT6xhVcGyV5ppFuTdkON75qlQpJLixEaU+BLwbWQy7+/egEPEisDSCI83ft
 3aH8fcxuhZD6XsiVXbZKih+kPSNPKBuu0O9/un9YC37QVP3QMYPwryNmXpBQClS4u8=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yLAILKCPSGk=;y4s2SKxblFf6I2c5Hh1WGxagP2c
 s3/HJr7M4R7iAGmMq7wRDbectAnOyqDRVNxXS6Xzt3QKbnwWpBSqY9uKvjn2bw1sci1ZyiVUT
 SjV85xR1mL1AxO6MTboC/ZaEeSdM+3Mk29biW/Ub8ZFeVxLR2sQYti0w8jMlnaJnJy2aQvo/v
 6VMyrzcAceMplQ2fa59EyVxw0HusL6QoVLxm2q1nNL1CWLPZyzS9Stw6jJlONtIogHah1slco
 tTQWnfNCmeAd00R/SPxPgMWW1+M61D1snxM8r8RNiCIIKPDOcQMXiR71F79LZ57uLJ4bfGECj
 fS0/quA302g+2RZRHfEhi9MReQ+gqmWDzFS356kdkNOHXtCJS2OT2BntjC++Dlr4cD4BwxrNI
 t2km0ERAAngZR6sR5qfAjQlrgcBxjYxd4wbvNkjSU/ejtwocRKsFT41W+6+7uMzsJzroj7Vs7
 xPo9fmkTCG++dSTjMtk0koV/2pwtUoowt8+il1W2+8Yeru1LLvNbIHZH+Z2LFBreBUgXz4tYs
 LEf212+L/Bz4dP3ofsE+su1Za2YLt/hdd5TDy5T9ooimfTcc+sjMdUctNyhwqiQH1aG8yqtpN
 06aXaiDnjxP7VXBTSEo3JuM8AE8c1KnsgPV2BJ2RPSiCdXUt1/ZSGEPfc62WLzVNfzbYANABU
 lMC1LJdN9+3XCAYmkHNinhbT/qUKhDWzeD1E3f+wBA==

Hi

any new state on this??

https://patchwork.kernel.org/project/linux-mediatek/patch/20240608080530.9436-2-linux@fw-web.de/

regards Frank

