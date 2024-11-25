Return-Path: <linux-kernel+bounces-420769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212839D82ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1809163928
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABF1917EE;
	Mon, 25 Nov 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OjQ3shT0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DDE190662
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528584; cv=none; b=MHcor/wskBJRyewDc6/OAPiDaKkLmbkDkHS03M0YgXeKHXw/G7NBlpR57tvTHdwPpbs5ht+9SbhZ9K8END9Fl8Y/sACLwtsoI+VM0xCoNpPKoxYstqmcj/yua/Ae0fuM+Ixi0rYbcToF0H7jaJPmlg4kZC1jD2LkeO2PXkQfAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528584; c=relaxed/simple;
	bh=p/PshTRquM9crRa/UAiKqOHwA2AjY+bMfpqDQbY+ioI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHqaRNZJYJTxxd8H23anoqBdn3y608x3pXF8QekxioOGo2oCoZKIaqXK3tUhWdfALbK59Yah0zUEyX9pShARKzcIEjpt6IsjCPOXunOCf2oZobRVYDFU/IhJmfMldOCZdxjDztzRmsX+sMtIWO45GVfO/ITrO9gzm9BG/VaYaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OjQ3shT0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732528580;
	bh=p/PshTRquM9crRa/UAiKqOHwA2AjY+bMfpqDQbY+ioI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OjQ3shT0h0gyDMX6aoq6xPUDNs9VbFysO61iCPn47eGLidX85PD2FQHSpqXbcxbT4
	 Iw/keTg87htaInf7isRghEDY6e1Zp50ZMcZ+J726X8JhLY8UB4aBLkEMzalpkjI5J4
	 f+7xBOiWxpqjTXimMjBhrwsXId2UPP28jc5SV9f0nDSo9p2pmloN3db888W7xJC2Pg
	 z+43iucMXm2xDocWVzA6y3zgYfSMKyIqXjtGRtCLoj7onskzypAHN8ajDl8pP+RVtt
	 oSStW5JltrynFzuhMHLBFQgGBYORPSpJDoRzUmAWqDGWUQVWfnqkzdOxBBaNc5w3AQ
	 FjVG00GMRO+TQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B644617E14D6;
	Mon, 25 Nov 2024 10:56:19 +0100 (CET)
Message-ID: <c3081927-050c-4807-9987-51d7265126e0@collabora.com>
Date: Mon, 25 Nov 2024 10:56:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] delay: Fix ndelay() spuriously treated as udelay()
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241121152931.51884-1-frederic@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241121152931.51884-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/11/24 16:29, Frederic Weisbecker ha scritto:
> A recent rework on delay functions wrongly ended up calling __udelay()
> instead of __ndelay() for nanosecond delays, increasing those by 1000.
> 
> As a result hangs have been observed on boot
> 
> Restore the right function calls.
> 
> Fixes: 19e2d91d8cb1 ("delay: Rework udelay and ndelay")
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



