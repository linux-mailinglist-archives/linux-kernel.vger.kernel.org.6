Return-Path: <linux-kernel+bounces-435952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43289E7F18
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B770318840C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D9113665A;
	Sat,  7 Dec 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARrCaxyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406882E3EB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733561310; cv=none; b=gXoyT0GZxgywaaTLQViqEIN9JKkB6V/yeX69e5uVhjLXhwico9aQQKBQomQLE1LpmcXRj8gzQ/vR4pbVsav5jMO5WVj4xTV6jwqlMQEH1QVd3H/BbcSwu9+jrBgb19hcMHnB93dEf/1QGxsvW6VDjh5YqQm9g/6UkRKfjmq2+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733561310; c=relaxed/simple;
	bh=CVM0mjv5RG7brvVCh3WS0X7N1BVIzQDL/bjpUuAkI8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDaM9FjfQn5tMCTdamKEXfzvl+e04XPMdRWYtqmRfXP9l9vWyrJM87naP1kSCor3zbUL2kGy4q3VTbM4WvR3gWDQKEZ4p1fGTLsGGZ38PJyd268D2vraJccGpEAp2nIZ0UOb5LlXenCAEXr1K3JZMpuY8aG4c5vfF6c+YHMvaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARrCaxyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8802C4CECD;
	Sat,  7 Dec 2024 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733561309;
	bh=CVM0mjv5RG7brvVCh3WS0X7N1BVIzQDL/bjpUuAkI8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARrCaxyPTlRedWz8BQ1b4n97z9HBC6LREwwRjDuyLW6J3wZqbR0xwoYsWQb1G5MMy
	 lpSpKGMi8po5BuW+ZxNNSQR/RE2biNnaesFZaKlpJuRs9c2O4HXIZCBofhMCf86EdY
	 VTNiLQD/4CzvnP9rub4gj4C/DqAJTG1l08LFDXi0mApCKkKBk3AZ5/p/1X4wF9zzPn
	 I3dAXnJ+Ouaw9lgyMkKZl0xegWhZPPDbi0BFcYOM0A11ntsLExdG0vmm6XGmCgSseG
	 3kCDJPdcF2f9UumX1EAX/znUld9mh/nWuwI+TTIz0zCsb8boyxEE64UHCWQjsX7p6Y
	 gx1v9PjtzimcQ==
Date: Sat, 7 Dec 2024 09:48:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor
 Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 31/31] FIXME: acpi/ghes: properly set data record size
Message-ID: <20241207094824.465c8bb6@foz.lan>
In-Reply-To: <87o71o2f09.fsf@pond.sub.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
	<104add143d349685cea1b47298b8f5d367a3a15e.1733504943.git.mchehab+huawei@kernel.org>
	<87o71o2f09.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 07 Dec 2024 07:17:42 +0100
Markus Armbruster <armbru@redhat.com> escreveu:

> Another subject line that suggests this isn't fully baked.  Respin to
> reduce confusion?

The last 3 patches on this series were purely to debug some things,
and aren't meant to be submitted. This particular one is just a potential
future cleanup. The FIXME there is just to remind me that I would need
to double check it, and provide a better description when submitting it
again.

Thanks,
Mauro

