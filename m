Return-Path: <linux-kernel+bounces-566334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A1A67688
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCB118926B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921520DD7D;
	Tue, 18 Mar 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N9qbVU5k"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544D1E871;
	Tue, 18 Mar 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308586; cv=none; b=lNTPyxu73vqPtI75vReCCOyNgWdULvZD7rvA+AQGyJYUHwV0GdyYUt9dfPoXLZ5/jQ/eTmTAPygOBKiDyKVOoySwOmRCG+3iYR2JkpTVHBGfpHPn+8hCGusSWBWnKBg9qVs3SlRQ7zszalaYnDynfWgqhfRYBvw7NGYQszmdAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308586; c=relaxed/simple;
	bh=BszjjWPBiRXCAq9+SjLvTIzV/2BzX1g3T0xH6nCwWTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaCBYnKdMrJAfyD8TTgufisua4AVhO5NfWKuSJH3SA+pTSlDoNF2BgrnMHsgO4RIZZrWxTYws12GLU0UdLAJ7jr2O6lEvEoZ4NXApItaJ07bnwyTreu7QxQ6GCrTttTP0aagEmN1sWv4yFTd7082cYdW+q9v8CkIT6T7WpF9PVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N9qbVU5k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742308583;
	bh=BszjjWPBiRXCAq9+SjLvTIzV/2BzX1g3T0xH6nCwWTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9qbVU5kRtV+7KHu9rj0ev9uLjhEERqRjGZc2JknKYmkqnLDdRbS73dXu3N5PptlM
	 jqtS6nFT+FEUsZTU8k8AAaKRu8pTCGU9PMh1t278ce68Q8SNcPp2ldlbbierlK66GW
	 pS+xYzH7KVviklv9a899v8A5IMMnRsJ9Y3gIT51JBqyjbrcFykUP+q+htdaEp/yQgI
	 OG4LYUJOCyp15uXDW7Rp9Ni1iYQSiblqenNuFCPdHXaq4P2SBEyRcUt5wxa+1utZHB
	 NskUmH0ZkkMQKOGTorPj8GxA0dKf26K0wor4ucSYqYN8Mt0KcZSD227oZWJ5OvPXBw
	 LsOmwZoAqAEuw==
Received: from notapiano (unknown [70.107.117.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6CA6317E0385;
	Tue, 18 Mar 2025 15:36:20 +0100 (CET)
Date: Tue, 18 Mar 2025 11:36:18 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	bleung@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH 1/2] platform/chrome: Add support for Google Spherion in
 HW prober
Message-ID: <f74001b3-ea40-4acc-b8a1-635532a5f205@notapiano>
References: <20250318102259.189289-1-laura.nao@collabora.com>
 <20250318102259.189289-2-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318102259.189289-2-laura.nao@collabora.com>

On Tue, Mar 18, 2025 at 11:22:58AM +0100, Laura Nao wrote:
> Add a new compatible entry for "google,spherion" to the hardware prober
> platform list, using the same I2C component prober and trackpad data as
> "google,hana".
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

