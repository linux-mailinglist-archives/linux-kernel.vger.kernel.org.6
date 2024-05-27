Return-Path: <linux-kernel+bounces-190117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F88CF9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D2B20CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FE717BB6;
	Mon, 27 May 2024 07:03:51 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB922079;
	Mon, 27 May 2024 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716793431; cv=none; b=Pm0UGbv08WBAYuXVqzs+8k4l+lQv5nvwC92N3edOx0pdnjMVRJucYiGAZmu4WFq5Y++zoil++t3WBSaSd/c/76jmQ0WZ+iX6e32nBYBQ5fH47anTTPDppBYLePg/0rSde0HE1wi3BnyUiQivJVdBGl8PQf/tr7idmugJPQ/Y6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716793431; c=relaxed/simple;
	bh=DLTFTO+ElmWnW2H0wkkUZ5YSFq5X29MkEh1ulLg/k6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSRg02mK+kFwvrt8YMLCjI7T1sT7Y8PQPV8mZ6y9UF9MUaeO2J5WlS4hXW84G8pIrMYpg25m3VqLuauleljwEaLiFjBeim+gj0vuM8eawSxceflx+DF3ulKMTJNGhY+D4Kl60u4+OhufQYYKZC32VG0ahVhbqbiFEpTLWzzPOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aeec2.dynamic.kabel-deutschland.de [95.90.238.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F287261E5FE01;
	Mon, 27 May 2024 09:03:12 +0200 (CEST)
Message-ID: <68cd93d3-eb34-4ccd-89c0-4fec449b52fd@molgen.mpg.de>
Date: Mon, 27 May 2024 09:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: 6lowpan: use DEV_STAT_INC() to avoid races
To: jiangyunshui@kylinos.cn
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
References: <20240527065258.1014049-1-jiangyunshui@kylinos.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240527065258.1014049-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear yunshui,


Thank you for your patch. One formal request:

Am 27.05.24 um 08:52 schrieb yunshui:
> syzbot/KCSAN reported that races happen when multiple cpus
> updating dev->stats.tx_error concurrently.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> Signed-off-by: yunshui <jiangyunshui@kylinos.cn>

Could you please use your full name? Maybe:

     $ git config --global user.name "Jiang Yunshui"
     $ git commit --amend --author="Jiang Yunshui <jiangyunshui@kylinos.cn>"

[…]


Kind regards,

Paul

