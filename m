Return-Path: <linux-kernel+bounces-410559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD79CDD47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBBEFB22B44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF411B6CF1;
	Fri, 15 Nov 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="LzcdeSTj"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705018FC92;
	Fri, 15 Nov 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669120; cv=none; b=r7OG7yJM1CSAuLVvrOQ2gvXD4s8Z38kif4SgQM1Z3Hb276JQ94ytrUg9/YeGeurLDHwxgSVe2nE4oh1I1/F6JLEewoCPbjKI9UustRDKJVspyhZ2qIMeB/xjvcUcIINnjPE+78AFcdWBj5uptNRwaOfs7gqXF7SFps538B6aVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669120; c=relaxed/simple;
	bh=OHnVyO7UOQh4Loqrg+RCr6IzM4VC4Q9TApvlvp6AwMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmSIfA4bibYXIj93EP3aTr6mqcHxLvodZbRRxzzMjiTrWV6DyKc2gU2M1MlSWXGVxxS7dnOzNULfBuanoqkhpwbKO0hZxqpfH29uh/k/ZZy8ch+9xqI0Yumb6aX+YLAfFyx5+Y7Ivp4PlqQpMPleqgn6zSZFCXY/u7/fj3jcGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=LzcdeSTj; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 5097E2FC0057;
	Fri, 15 Nov 2024 12:11:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731669114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHnVyO7UOQh4Loqrg+RCr6IzM4VC4Q9TApvlvp6AwMo=;
	b=LzcdeSTjGz/B63rdmfERn24TiHGEdie+RsQXx8Z+/1NUNW7yQ5JNnd6HoKKfdAOql+8Mbc
	r1u2F3sLRAMN0Mn9XGJ4Os6WUnY1XRw74n4xGRqoOXzPmmkhk0R6vNDbHZ0HcfA1HepdOV
	T9Apaz/9+3VAPGlRwmP9W/7GsVsgQLE=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <635639b1-bb61-49dd-84b6-b2db82b7c24f@tuxedocomputers.com>
Date: Fri, 15 Nov 2024 12:11:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/licensing: Clarify wording about "GPL" and
 "Proprietary"
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spdx@vger.kernel.org, workflows@vger.kernel.org
References: <20241115103842.585207-2-ukleinek@kernel.org>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20241115103842.585207-2-ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 15.11.24 um 11:38 schrieb Uwe Kleine-König:
> There are currently some doubts about out-of-tree kernel modules licensed
> under GPLv3 and if they are supposed to be able to use symbols exported
> using EXPORT_SYMBOL_GPL.
>
> Clarify that "Proprietary" means anything non-GPL2 even though the
> license might be an open source license. Also disambiguate "GPL
> compatible" to "GPLv2 compatible".
>
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>

Thanks for adding this clarification.

Kind regards,

Werner Sembach


