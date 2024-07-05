Return-Path: <linux-kernel+bounces-242810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C9D928D69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E85B23386
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B37713E3EA;
	Fri,  5 Jul 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XRhJlPub"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DF13D250;
	Fri,  5 Jul 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203341; cv=none; b=L2IDglflvgoklS/WV1MXIbqR5NUqWaKQQfRVwNiTSrDII6yEGb7qLygr4S5xLQznoPFNj6r3k8O1i0vSAdEmuRW4tSfwl0R3tX4QrzkiBHFmGt0K3c6Oz97HCBRk0Mw1FLjtLlGivSgBi8Ia2FZ1FkNOjt0AIIt+UDoVXgOhgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203341; c=relaxed/simple;
	bh=EDP2ifnRzWqTkXf11nQBguv93rlxlowAx6Co1bEhv4g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=NsttAyKxBeEExHceUkY96jsyHZmjHNEMXUM7twn7v3Tzq5THN+WJue3pdxu1w4L+tAiR3lDI0UCb39za1X8acPI2MowxNUk2ujnxMUtd1Q/eEmW1rD992lP0prb0Wc127oVx3+4ofdczYMHNwGoOQjegDfto9fg0dQMTfIqvifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XRhJlPub; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:References:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=oxOs7hxC3MgGJ5/HFt6vN8kZCBbYAMXP979J3TkNiyI=; t=1720203339;
	x=1720635339; b=XRhJlPubGCXWliYV0TMSrzUeK325zhvDr71lOmmGUnRGty3rJU/l/C93eZ4pL
	JaMWAbBKm2SCL5Xq11DGuYv2H0IWPzMzKveE6MN2cAXX2Rkm9gQKtyMv8LqLJSDpUWTUzkwtJ49Dr
	4M5oSSx8o+MUvV3vsQJNNb+IMagIXLRKjRuP2GJUPT+NTOiKEFXAjfzu5rHt2dzxUQT2/rl7hbSpP
	6VnL9a2lxPv+eSkzZy4n5VDGerux4BslfmlCu+pG5JsYXfJqa6S6kX08dvetxZQgxrv2Fv372s4g3
	VPqi3OMcIgR4QWxvgbsSaY2mOg9V03sVtJ8FRDt1+7AQej+c3A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sPnT7-0008Iu-1L; Fri, 05 Jul 2024 20:15:37 +0200
Message-ID: <b546d9e0-b52f-4b64-8247-3c85026f3b36@leemhuis.info>
Date: Fri, 5 Jul 2024 20:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux regressions report for mainline [2024-06-30]
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <171976397650.2207205.3016482698479351675@leemhuis.info>
Content-Language: en-US, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <171976397650.2207205.3016482698479351675@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1720203339;34d1049b;
X-HE-SMSGID: 1sPnT7-0008Iu-1L

On 30.06.24 18:13, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> Hi Linus, find below the weekly report for regressions introduced
> during this cycle. Overall it does not look to bad, but a bit worse then
> in the recent cycles. But there are a few discussions I will prod
> tomorrow to hopefully get a few of those resolved before -rc7; I might
> CC you on some of those threads if no resolution comes into sight soon.

Hi Linus, as -rc7 is due, here is a quick "extra" report in case you
want to know about regressions for which fixes already exist, that might
or might not make it to you during the next week.

* It seems the following compile fix fall through the cracks somewhat,
as it is only queued for -next:
https://lore.kernel.org/bpf/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/

  It fixes a compile problem that was apparently introduced this cycle.
This was recently brought up on the list, but seems nothing happened
since then; someone else complained about this problem to me in the
Fediverse today, too.
https://lore.kernel.org/all/d0dd2457-ab58-1b08-caa4-93eaa2de221e@nerdbynature.de/



* The following fix for f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to
share GPIO pins") took a while to get reviewed, but with a bit of luck
will be picked up by the drm subsystem soon and make it to you next week:
https://lore.kernel.org/lkml/20240630221931.1650565-1-aford173@gmail.com/


Ohh, and btw: the following fix for a 6.9 regression affecting arm
MMUless devices is also slowly progressing; not sure if someone will
finally pick this up next week:
https://lore.kernel.org/all/20240611100947.32241-1-yangyj.ee@gmail.com/

Ciao, Thorsten

