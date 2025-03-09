Return-Path: <linux-kernel+bounces-553070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94CBA5830E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A6A3AC482
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755B1A317F;
	Sun,  9 Mar 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eOvl5Qjf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0206C2C8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516367; cv=none; b=N19kH2Il5/2d+T0yxaQVb60WBq4HP1tZxFsbnG6LA/Ln/KDlE8N+zaCALz0TwTGKFeTfFVWpua05/3YLaltToczOEp0tAIsxr+/JjFDQ5HjWUAhZ7D9NzqsDHTkn59L9ouXscLXK3HNscg2DxP2b6Os2iIGpCHowlf1SUkv4ZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516367; c=relaxed/simple;
	bh=JNrhIUCl8uKi2zGaj3/5wmGyxr3eXLSdAcYya8I097M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvAVVlSCjNfqDVTwSI2iNgCS96b3Wo7s8fIBBFxyfBlWD80anOvLcoGdPdXRppQb/UFB71a9FAsirxRnD8HADkBnU5wlPF5GhUC2sEafzTh8OVM42EMh7l8yxzP1LFcek4v468o/qAS7rZemNowtd41FXAP6A8IQjeJQI3vgDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eOvl5Qjf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741516364;
	bh=JNrhIUCl8uKi2zGaj3/5wmGyxr3eXLSdAcYya8I097M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eOvl5QjfMn0ehXW+yjOg/C2Wlgqm5TwbMy8zOJDl4wTd/8N7s+YDpdtaCY2noon17
	 5DscJYUNLrxlNDs4AXY9GkJ8pYGtfTDT7qQbkKv8Ke+mAbJVY9f8T4qym3Cgegs/S2
	 Sy7nrsPvVd24Y2eYIUHmwXOZR9UHr+UPtXsii1HZBZHLDvwqQprA3qkC00UViMdIhl
	 VrlTrqe5GPMDQl7Mxn7nqUOokkYsCCkdWazQ3g+NoRVWw8E0TXnLyS/Yw8HViy16iq
	 ZUFaBxRe2WjHvgJbK8M0OdT+Vnu0cGblpGUps9EDZErep6nQnnyZhO6Uk7RlM5XCcV
	 sH+BDFEXL8kwg==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8025817E05C1;
	Sun,  9 Mar 2025 11:32:43 +0100 (CET)
Message-ID: <884acd6e-4936-4b00-88ed-cbccc10efc9c@collabora.com>
Date: Sun, 9 Mar 2025 12:32:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] phy: rockchip: samsung-hdptx: Optimize internal
 rate handling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-11-35087287f9d1@collabora.com>
 <CAA8EJpqzZaRoQ5mDeKUHpNhYsegC=V6c2SQpKaQn4FYhozQn1A@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAA8EJpqzZaRoQ5mDeKUHpNhYsegC=V6c2SQpKaQn4FYhozQn1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 12:17 PM, Dmitry Baryshkov wrote:
> On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> Drop the rate parameter from a bunch of internal helpers and, instead,
>> make better use of the newly introduced ->hdmi_cfg.tmds_char_rate driver
>> data.
>>
>> Additionally, rename the rather ambiguous ->rate member of struct
>> rk_hdptx_phy to ->hw_rate and ensure rk_hdptx_ropll_tmds_cmn_config()
> 
> Would it be better to name it tmds_char_rate?

This is only used in rk_hdptx_phy_clk_recalc_rate() to provide the
actual rate programmed in hardware, hence the "hw_rate" naming.
Renaming it to tmds_char_rate might add some confusion with the similar
one in ->hdmi_cfg, but I don't really have any strong preference here.

>> updates it only after all the other operations have been successful.
> 
> Please don't mix refactoring / renames and the actual code changes.

Right, I should have moved that to a dedicated patch.  Will handle in
the next revision.

Thanks,
Cristian

