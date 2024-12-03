Return-Path: <linux-kernel+bounces-429056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17369E16C8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B0616179C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6191DF271;
	Tue,  3 Dec 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oVSy9zsL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2931DE3C8;
	Tue,  3 Dec 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216971; cv=none; b=d8gQf/GSQSWjX3krLhjGSK9hq98Ah2eJL9353o8ScaFvKJz80jdG0FRpuzmbNoSGEZ7e5qDj3Sr6WXrVCv0Sqypd8S06BzF1OJJCH6RfJVcDn6sDuVUF+YdkJhSXQEtFMd4cEUna7wg2wkuAz4SKxTaTuLPP1OxBm5Be8cXOqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216971; c=relaxed/simple;
	bh=43dP5gag6479cvqOzhHxvQanA/N937ViWuDqgCPC94c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=th5toSHzN29O1jxXc1Vtwpmj9yYi6SVlkUBfdzDAhS5EFbskHYnyd80/GnV6kaX438agTfnkdZwuaF4eGhrfVVO+BJFKq6NoJQDOXT2uRCcmtRrKWU13oMTAYtln4jRyZj290M6JVzPIfcq3OVin5E4YR9zXsfDgBR0IHpV7KNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oVSy9zsL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733216968;
	bh=43dP5gag6479cvqOzhHxvQanA/N937ViWuDqgCPC94c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oVSy9zsLRzL7lbm5YQreVe75XNM5I+OGg+cqJp2cNUkIKz4gw48K0CU6CtQ18UuAk
	 DtykMVrzqQ2pF9B9qazwHq1ZJkePHCW0Df4ryjKRnflieg/avxVuITqq+am8zVH9qi
	 U6fIPgNSra0WDXbatW1OONxQF9mG2jHSAA64bJJQb0jGaAxXht0Kt6tX3rBlI+501V
	 2Tly3NxJr3synyy6JxW3dJlOihwUgqH7Xx+O0ux7Z9E+rueKIRtXv9JfSuJ2IPzEzT
	 T480lbh/9f1GFhg0e0uaHUHfekeKzwPh/Uty/8CkdTbNptoX7voNUBSETNm6RAP382
	 gvFbIXomGJi2Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B0B0217E14FB;
	Tue,  3 Dec 2024 10:09:27 +0100 (CET)
Message-ID: <9c560103-4930-4cdf-b7f5-1c75785b7216@collabora.com>
Date: Tue, 3 Dec 2024 10:09:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] arm64: dts: mediatek: Add exton node for DP bridge
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, wenst@chromium.org, hsinyi@chromium.org,
 sean.wang@mediatek.com, dianders@google.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20241202032035.29045-4-xiazhengqiao@huaqin.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202032035.29045-4-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 04:20, Zhengqiao Xia ha scritto:
> Add exton node for DP bridge to make the display work properly.
> 
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



