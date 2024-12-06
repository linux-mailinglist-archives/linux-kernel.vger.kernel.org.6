Return-Path: <linux-kernel+bounces-435304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE39E75E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B8E18820E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC43420C495;
	Fri,  6 Dec 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ap8hDjVN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7C8C07;
	Fri,  6 Dec 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502462; cv=none; b=og0FFJKOdDa1onKVSFikde6aPFvQiJM+huyHUN1hSL78r1AIb1u69cdOKv/KeNjVg4DXZRQ3YpTX3H9/ZS5PSdTW8k+v4nKN7k5kwo4LK5kWnbyrAV6jVFrcK6QjY4NSDyy7QDIZy7jYwI4vVW4d/XGTfffBXZ/J8Oen54qs5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502462; c=relaxed/simple;
	bh=hvAaymPk284uiYa41ZbT5MBYrYQRTDAHbY8Rm58S7os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=huuQT0iBzuFDPrW4VpUeFx57XJpdPA4uawE/Dm2csVY/Hs3tozMjzKInd+2UqBO9TPAeqYwxHwSeRv1PEKqGAKEveASBtu3yxvdlQnsnz0GHxC66SAnSjetvzIY8Ez+UKAObPWGPUBpO4JC7BE97mnID5YoMkk9R1vsgEV8nHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ap8hDjVN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9D9FE403FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733502457; bh=6bDwhwd7F+ltCaNQrriFrq3XmSp45YFku6FWxZyMRQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ap8hDjVNxCm/4JpAVr++l/9pBWyE/choRnnBcTJYXnBOKg8jLvYcHOe0YpeJ9qSan
	 7DmnUeX/x3ozmH4N4kTIAjmHYzeRGk6aGNQmNsLlYkNqTApr6qFZU0A//DDEal7bIM
	 pWLE6tUgmGpxQYXSFSAYx4+2Fo57H4JGegDpFuGeSOtX1KRGVSRDYx2pt8jR97O6WO
	 7roxcWrGxcg8rLH8E8FOW3YdJtbYpyfBvuJq2p7rdOWG30Cm2fhWLFsudgzWUqzwHA
	 qkR+4X9tscVYNykKSLuVG36i19aQDyRMn4WKvrlfBSmA1B+yDWtAhyByUpPbYTpwx8
	 RYW6ukXY9fq6w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9D9FE403FB;
	Fri,  6 Dec 2024 16:27:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, avadhut.naik@amd.com,
 bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] docs/sp_SP: Translate development process into Spanish
In-Reply-To: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
References: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
Date: Fri, 06 Dec 2024 09:27:36 -0700
Message-ID: <87ttbgu687.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:

> From: Avadhut Naik <avadhut.naik@amd.com>
>
> This patchset translates the remaining documents of development-process
> into Spanish.
>
> The first patch translates process/3.Early-stage into Spanish.
>
> The second patch translates process/4.Coding into Spanish.
>
> The third patch translates process/5.Posting into Spanish.
>
> The fourth patch translates process/6.Followthrough into Spanish.
>
> The fifth patch translates process/7.AdvancedTopics into Spanish.
>
> The sixth patch translates process/8.Conclusion into Spanish.
>
> The seventh patch moves development-process to the top of the index for
> translated docs to match the layout in the main Documentation index.
>
> Avadhut Naik (3):
>   docs/sp_SP: Add translation of process/5.Posting.rst
>   docs/sp_SP: Add translation of process/7.AdvancedTopics.rst
>   docs/sp_SP: Add translation of process/8.Conclusion.rst
>
> Carlos Bilbao (4):
>   docs/sp_SP: Add translation of process/3.Early-stage.rst
>   docs/sp_SP: Add translation of process/4.Coding.rst
>   docs/sp_SP: Add translation of process/6.Followthrough.rst
>   docs/sp_SP: Move development-process to top of index
>
>  .../sp_SP/process/3.Early-stage.rst           | 234 ++++++++-
>  .../translations/sp_SP/process/4.Coding.rst   | 463 +++++++++++++++++-
>  .../translations/sp_SP/process/5.Posting.rst  | 388 ++++++++++++++-
>  .../sp_SP/process/6.Followthrough.rst         | 223 ++++++++-
>  .../sp_SP/process/7.AdvancedTopics.rst        | 207 +++++++-
>  .../sp_SP/process/8.Conclusion.rst            |  75 ++-
>  .../sp_SP/process/development-process.rst     |  21 +-
>  .../translations/sp_SP/process/index.rst      |   2 +-
>  8 files changed, 1590 insertions(+), 23 deletions(-)

I've applied the set, thanks.

jon

