Return-Path: <linux-kernel+bounces-566343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0D1A676A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE84F3B4C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8320E307;
	Tue, 18 Mar 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WoE14fUJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720B20D505;
	Tue, 18 Mar 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308762; cv=none; b=d4f5P7x/ly52TkAbtznIrb/HOQ+nOX6C5GBxGvB8fso/ku83z+B3qI1Vny+WqqKrzo2Ii91TxaVhxTOudiimqM3WGk+CiL5IMMiuAAVGOLtVmsPlCdFZQE53+iu09WZRl1aaRou7vah1E0q3yQkuHA6wB49wJszPQAxjYySfWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308762; c=relaxed/simple;
	bh=GisOJD1TXdv+jG24Ahwf9nT6eMF5RJa4fPp5r1uc6Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk1MLcbdcRerVxkBVzpyA0tKtcevWGbgyk1pe8SY1z9PmX1pGVmoflEsErp7FYGSuyiJ0ggIULP+7xGsoVD+Htw+KJ120by6K4JBcjcxnYgpcgJEnsRli/e8C0IbArLpnXY3n3hHe9OYVT7ljaKe4hflakurHQNLtWhKlPp66DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WoE14fUJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742308759;
	bh=GisOJD1TXdv+jG24Ahwf9nT6eMF5RJa4fPp5r1uc6Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoE14fUJZ6fME93bMNeZXwEKFpbI5E49q1n+St6f/Yv66ougqdVwgdLF45oIe1c1Y
	 UOL1s95gHnX5wxp39zjsATuqXfQkMW1BBoD84kULqDhESIvsKE9J4VaJRb1hgfmHs2
	 iBiNTrHBkx3ssyJ9fRXkUt8xm5ryvqBFcy50EByUrdcnLWnfC5LRuP2N328cGBNHtN
	 1bC5jGezSBj+e8anturw7+FEE0kDKnncPzdGXeLyjLrhuHRoYp8AhcRClT6YhsJSBw
	 +CmzTxwoO1jwwVCaSWq35V4e2SzXhUS5niGApmorJSMrtoMeR8umoeuD6SsyS1twXo
	 DWUELs2Ci2Swg==
Received: from notapiano (unknown [70.107.117.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BCF7817E0B25;
	Tue, 18 Mar 2025 15:39:16 +0100 (CET)
Date: Tue, 18 Mar 2025 11:39:14 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	bleung@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8192-asurada-spherion: Mark
 trackpads as fail-needs-probe
Message-ID: <f80dfa43-74f4-431b-934c-e103b8204276@notapiano>
References: <20250318102259.189289-1-laura.nao@collabora.com>
 <20250318102259.189289-3-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318102259.189289-3-laura.nao@collabora.com>

On Tue, Mar 18, 2025 at 11:22:59AM +0100, Laura Nao wrote:
> Different Spherion variants use different trackpads on the same I2C2
> bus. Instead of enabling all of them by default, mark them as
> "fail-needs-probe" and let the implementation determine which one is
> actually present.
> 
> Additionally, move the trackpad pinctrl entry back to the individual
> trackpad nodes.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

With these patches only the right trackpad is enabled on my Spherion and it
works as expected.

Thanks,
Nícolas

