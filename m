Return-Path: <linux-kernel+bounces-439096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02F9EAABB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DAB188A6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049FB2309A1;
	Tue, 10 Dec 2024 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ovDlKYiX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889C230982;
	Tue, 10 Dec 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819534; cv=none; b=OA9l81YiPdFvxebMrz1JRuRjpduAhrrJwHzy4vFW0nObP99muirDgTScKl7TO8aRfInZeVD3avMHyTwDZ135nCy6I4HUPDcOBh7UiVPGMa1vjYJpv8WMD6v7CUj15nBcp34bVLv11DWyLMRjRhKAXlN8BxGclnFaFrEw4FukYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819534; c=relaxed/simple;
	bh=n8e/j3rajoB9/ZiaEY3WAVPbJONb+u5IOygQbHZsF7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0m19Pg8a4Q0OKxx51tCJEdDpg8tnBETfmAuwh0c/l2cPybK98uTudHq9ylcwOfXdafuPoHFdEibsDU2zSPIR0tNSTLqykv87zZXLaRS7Jz9W6WxoAII9IFfccfddS5v2oIad3U8uI1/Z0QNFAqdKnHlv7o000PBzThswqmjhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ovDlKYiX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819531;
	bh=n8e/j3rajoB9/ZiaEY3WAVPbJONb+u5IOygQbHZsF7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ovDlKYiXXO3tJGCZbcwjFkT7+kuztqhqvUzkNwz4//El+zn0w8vaFlLH31ubbHBfq
	 59v2QCYKJ/4wPkLeJkMwEN8Gps5YykbQTjEzQHXBmh+1f82AWjCtXjFp4PCHboYqTD
	 l/8+2dJ1N4a2HCR8yfGEwxNp14LFIY5IIJzRPRlYeEQ7tQ95odIBbh//PCIlBJTHeF
	 d/vVrKE7ylie7Ja1PEwgrZBweFwdlkdMivwLclU3t0cEpCRWSOhFdWKK86cje1vOne
	 qs9nBnfObv18qodQCJ9m9y75TgrfUmp7HEhD8QpNNT133B+va9Pz9D2Lwq2G3fb6jZ
	 NorrQGudizMFQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5808817E14EA;
	Tue, 10 Dec 2024 09:32:10 +0100 (CET)
Message-ID: <d65fc527-5919-4454-865c-4731944e48a7@collabora.com>
Date: Tue, 10 Dec 2024 09:32:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: mediatek: Add mtk-apu-mailbox driver
To: =?UTF-8?B?S2FybCBMaSAo5p2O5pm65ZiJKQ==?= <Karl.Li@mediatek.com>
Cc: =?UTF-8?B?Q2h1bmd5aW5nIEx1ICjlkYLlv6DnqY4p?= <Chungying.Lu@mediatek.com>,
 =?UTF-8?B?QW5keSBUZW5nICjphKflpoLlro8p?= <Andy.Teng@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?Q2hpZW4tQ2hpaCBUc2VuZyAo5pu+5bu65pm6KQ==?=
 <Chien-Chih.Tseng@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>
References: <20241024092608.431581-1-karl.li@mediatek.com>
 <20241024092608.431581-4-karl.li@mediatek.com>
 <083c8f7b-0969-4ca3-8a91-35f5767c5f32@collabora.com>
 <CAGXv+5Fw+qZhTTgJq0QdiQHgiQP2ByR1tgae2+k4erx+0fp61g@mail.gmail.com>
 <a3c3280478bf86eb97a422782ce60ec4eaa35224.camel@mediatek.com>
 <0f98405c40530d81c342af06dea593e7babedeac.camel@mediatek.com>
 <cf75f3c3932ddc50f5697bc4f394bd77fc16cd39.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <cf75f3c3932ddc50f5697bc4f394bd77fc16cd39.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/12/24 08:32, Karl Li (李智嘉) ha scritto:
> On Thu, 2024-12-05 at 07:05 +0000, Karl Li (李智嘉) wrote:
>> Dead maintainers,

LOL :-D

> "Dear" maintainers. Really sorry for the typo...
>>
>> I hope you're doing well. Just a warm reminder that we're following
>> up
>> on these patch and really appreciate any feedback you might have.

I already gave you feedback on this patch.

Cheers,
Angelo

>>
>> Thanks you in advance for your review.
>>
>> Regards,
>> Karl
>>

