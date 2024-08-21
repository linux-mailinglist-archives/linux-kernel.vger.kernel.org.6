Return-Path: <linux-kernel+bounces-295903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D695A2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44AD1F234B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650114F9F3;
	Wed, 21 Aug 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Ror14IGH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A278C60
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257589; cv=none; b=tFSwXpqSXF/opLq05uJ/RzWXkR8zi0ydZ+gt9mOmrE6rfkudl6lcNvYBQsD5aEZCuEmI5A9JkO7MCHpSPy99vcQAfFKPUCVWArzzp94JJHlIgc+QZhK95YD+Hv98h2IUdwmQ0WBDzEv/b/fblRtSJymqvlEPmCUPBhIqUygDiQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257589; c=relaxed/simple;
	bh=YF6gyiVlhGTLdTXt+EENJi25kOKALETSZYPKLEIUa9I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dodqXIguZshsQ2y7+WR2iKkcgVtDk+CYJHr8LPHtxro5jWcvOgN7OTUKc8FE7CnTgYhUDGKb81x7zOPufqGTgVCazv0Y2eUQ/mFUcKnzFgD6YbQDBMDbmLgC8+vR17vKWwfcsz3cnYBhv7ntBqQcQHVHmki7nrw8y8tSa4jpFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Ror14IGH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724257517; x=1724862317; i=efault@gmx.de;
	bh=Jud1ZACtHzw2oQppEFvFul+X+uGwCbLIpeVGDSp7gTI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ror14IGHFLgRGrx6Vbs0AxsZYT+DfQpP/G4wZoJDgf3QbCoisqoDAyAZP1V/v8BY
	 FN42OHFMCuuMx2z+u0gK661v1JrMqiLgp5Fvv9mQWJ+4BODDNdDSeEMZjtbwN4sax
	 p2qGqWeOGrBjkQSknXTfMBFANJ0qNjTiGHtiddBt+ryE03qXh2sTW6wktCswybg7B
	 OiPOtJCJWNj4WnImfSyAsqnA/6nToTRprt/gcHNMfhewTV0sExyXTWHcUpbnNbXhD
	 0lwOI+XDVe32f+5n21MUpTQAYhGQeQ7MmP+Obttc9Zb7+E+e5sjHWRmkdBRcnnsWZ
	 mym5zploN9ppvEq05w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.208]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1suIfc1xon-00EK7Q; Wed, 21
 Aug 2024 18:25:17 +0200
Message-ID: <6ee2f585c35f69aa3ab21193ac2648a91318b2c5.camel@gmx.de>
Subject: Re: [PATCH 00/24] Complete EEVDF
From: Mike Galbraith <efault@gmx.de>
To: Hongyan Xia <hongyan.xia2@arm.com>, Peter Zijlstra
 <peterz@infradead.org>,  mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org,  dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,  tglx@linutronix.de
Date: Wed, 21 Aug 2024 18:25:15 +0200
In-Reply-To: <717e6294-5c62-415c-bc8b-5da1d8ac3642@arm.com>
References: <20240727102732.960974693@infradead.org>
	 <c6a673d4-ee16-4458-bf68-8f75d5062984@arm.com>
	 <717e6294-5c62-415c-bc8b-5da1d8ac3642@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KJ9Wf/i6X9mXBfQyQRReVoPrZo6ZqnUolaXRqDqtAJ/qs/ryUjM
 itzM0C7NlWnQKwDUcMwa4e/te0JGuWaAJxwITXRBxlrvwvnmyiy4oYGyj5Gb5hFopT10EIf
 kxx6a9GoI6j7no+JEXkuQ1DIEv2fAFQnvW4w7WGChzcpEsM+T1SIq+3nMlbUtB6P916l1zU
 Jucx98Jm1fo52xq37HYoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vu8JjvznpOs=;nk/yP7eBNz0BIW0zfvIXEfQWp7e
 7ih5RUMq5FBLQ585r/LV8NmsHd4/uQArTY47eCbp6zuoj1sGQH3wgaojzevBcr2No9Jm89gWO
 6Y/j/N87mhwtEjJ+zm+HLYGRGFe6U8mk5KybD23nq8WVyTQDo33VN1AJmlPtfnttYj8GL/rFM
 qyTVjO0p5OJ2QtgfM3jDtEfI+KZfjH0miBKtuhRfWNnYBU07o3RE+vox/o/GS9oTphW3ocebo
 mKKItCBIm2+R/qSd8tcXJDa/DK6k+4hnMN7mI4nlJdcX5PERQ9HKr89WyqFiMuFzGlm6Ky7Hk
 5FV9IpnySS8lSbMgrkVMd8klI/OKBIW6M3ZnmiefiHKU63m3kiMfZopavlyLZckZw6MCAfQOl
 oXjq4ghJoozhIsZMRpJWsk1H0JS/0tvD8UnDYrV8EUyfdPrrWdmpFRK17xgoRKjIBXZ/ktPiS
 aHPhJaA52DH5aGhLHeZCD/Igum5EjsqGdW7CPjsmLWZ1P5Dzve3i6AwzHzolynXjEpa0+RQgv
 wsSG5i93iP6jaQ9qNqPpaSu1cJpogshqv/jMmX/zuE74lQX0qPxxfXMAHrDt6o4qwSwB9uGfN
 Rv27xmakred/UFP4bVDxAlsLzkCbzPgQvTfuNXXCINnGb7PLfuY08LMz5KUyfaImPcJxNAVt7
 CHCOGD2Sm5bbnAc8EZCB2r7Qck27yRUQ5286Z5/+z4ZGp/iCdxLD8qN6Q5y8BQfLIK09ibL10
 2btzEWX/DnZxfLqS3JeQz8o2IpNXt9nu2aGjqkq743GQxI4Pg+Xr8rIEfk/7cVvM/5bZDdUbP
 NhYb9pV1gzjOFiD3lTW0TDTQ==

On Wed, 2024-08-21 at 10:46 +0100, Hongyan Xia wrote:
>
> If I undefine CONFIG_SCHEDSTATS, then it boots fine, and I wonder if
> this is the reason why other people are not seeing this. This is
> probably not EEVDF but DL refactoring related.

FWIW, tip.today boots/runs gripe free on dinky rpi4b (SCHEDSTATS=3Dy).

	-Mike


