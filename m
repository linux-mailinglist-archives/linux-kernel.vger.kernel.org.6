Return-Path: <linux-kernel+bounces-423506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456D9DA891
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0397A162161
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B71FCF7C;
	Wed, 27 Nov 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cwZd3/8T"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8313618FC7E;
	Wed, 27 Nov 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714491; cv=none; b=m6cat4gE9LmlsS0yvlqNWjkif7q1c0Tkxo8tRqwORpsZUvDiHPReMwZuPbD1aMpWn2IiKysXyFXycY9sr1jnSltqHBh7ljhRIurqlW85CZr2GERndAahf95vtSwKhQpZs2MupjxvXIkAVySRKx43MxZd/xhi0hr560c6IkMX9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714491; c=relaxed/simple;
	bh=+KLv+7B67Pj73+MfMlBhlmU3H9GCiOye62ujVxuxz/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skjRrSvmROCJvTGzPH3/PrX1Tn3xbtjPL5CxWhmFm/hJmmhw/BWGAlN0SFLCoeoae9Q3bzwnlIcKANvtnC/i/h1YWxSa/tKb4YmDV62G6UhzjzYRbm6vVsgRWEi/Qj5TIbHmq5KRWPB0W41PT9k+G0bsoB8C87a0FprbH/9+aVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cwZd3/8T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732714487;
	bh=+KLv+7B67Pj73+MfMlBhlmU3H9GCiOye62ujVxuxz/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cwZd3/8T30EANXVeNYt4ThGyscNLAqf6K+nWZd0RF/FiyxVlP8Ljl54mz9mOM7/yW
	 a0CmqQTtr5s9P8ZPQOWMIntn1wDbEttz88piUhmoV/LaQ4Tg1O05PXioXUfoR4flSz
	 mGeBz/VEqWzkGbnaDrPKtj4Ir7P3MoeX0He2x6959CyRRjJtquaapCKF3EB5eOQzAj
	 K15xwDbAQk9LWT1/Izmp+stthIdKYpashJmKbuFEwePJy9IN0zxW9kvt5hEq8ozeMb
	 g9+Z6+XdevRWGXMyYmro3pziDqUjS5mvexBe+PIS1qcVnoqCWpuQAMg2srV5gE/cMn
	 0q9CFrh69ARiQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E31817E3704;
	Wed, 27 Nov 2024 14:34:47 +0100 (CET)
Message-ID: <52d323d8-1896-45c6-a826-2e3f4832efe0@collabora.com>
Date: Wed, 27 Nov 2024 14:34:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 01/14] arm64: dts: mediatek: mt7988: add missing label
 for apmixedsys
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-2-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241029103937.45852-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/24 11:39, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Label to allow easier referencing in dtsi and board dts.

Please add the necessary label(s) along with the addition of their users.

Don't just add them randomly like this "for later" without any valid justification
(where a justified addition is one that shows that you're adding the label and
that you're using it somewhere!)

Thanks,
Angelo


