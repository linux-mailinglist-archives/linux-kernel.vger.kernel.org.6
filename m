Return-Path: <linux-kernel+bounces-374434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA29A6A29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C731F247AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456E1F7092;
	Mon, 21 Oct 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lc3Zgqu7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25C1E1C3B;
	Mon, 21 Oct 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517223; cv=none; b=ppn4SKEsDe3Xbrg+a1M+Ngtvk9H1uOdcFcH8eZ5uc/m6QgjHdCA9mLHtf3zc1ezKonngUntVGQFLspzDzyAO9gLntMGw/YgYSxOGntNxNwU0+4L6bm8gdXy33bj0oyqLBtG+wazCpI+yK1xue2BLR9RssZFen2+AWBeYCBwUxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517223; c=relaxed/simple;
	bh=mTIoVtYVIb9LlICU5RHcqT1i6f0rLph2WFVJzpdQiZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqkTJVFcpG37qUHBkbjtJnS/XfJMd9c07s1rE9d7zLxLAq96uGofNQkZJzrDDp3noWfIGGMosB+3QOEFQCCyvTzyyocSsT+KRivx2XyxhqrO0p4Um7X8cGKDEIw19b+7FTmuDu6J5ceMir5zxP+2xTkhhzzXXsEtjXWbF0y2EO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lc3Zgqu7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729517219;
	bh=mTIoVtYVIb9LlICU5RHcqT1i6f0rLph2WFVJzpdQiZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lc3Zgqu7X/SsLog0UfF+/eTEoJKPIj+GB2GL2oy6/oIUToR0qwGnCWBqM0frfHDWD
	 1NjRG/lj0rJKiCjzXVebXWzfPF+f2nCTAnXd81yOkDlDIOLJVfu2YCbpNXVuvhXGoZ
	 gXbSpoScmsSvvxiYUJRPDmclITjcrmuOKsT+2i2tqOtZgF8Dw/seuuWVR3ldafDvw+
	 XGVmR0WiGBACvrQmih+7+Tk4rKsuDhYqYY4AT0FXj7h5EfArVyP6ce/BLs8EdcIRsX
	 gjOnpwS9XQKiKpfXsLJ1/VRMmnGWJSOIQep+NUGHL2Psr7pLpNhdh5ASlkodeQ360o
	 ZMMzt/aB8/sAQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2021217E10AC;
	Mon, 21 Oct 2024 15:26:59 +0200 (CEST)
Message-ID: <93dbd4e5-6cd9-435d-962d-b6c261df899c@collabora.com>
Date: Mon, 21 Oct 2024 15:26:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply
 to second source trackpad
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241018082001.1296963-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018082001.1296963-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 10:20, Chen-Yu Tsai ha scritto:
> The Hana device has a second source option trackpad, but it is missing
> its regulator supply. It only works because the regulator is marked as
> always-on.
> 
> Add the regulator supply, but leave out the post-power-on delay. Instead,
> document the post-power-on delay along with the reason for not adding
> it in a comment.
> 
> Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



