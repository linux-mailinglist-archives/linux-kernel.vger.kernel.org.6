Return-Path: <linux-kernel+bounces-343040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B811989622
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460FD1C2135D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF814A61B;
	Sun, 29 Sep 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MqK4WKCz"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A314287;
	Sun, 29 Sep 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727624165; cv=pass; b=XWXNzdWnEq1N+x7EXmM4ilR3CH3E4zY2aBhej1kYL6Zow0CUhObr0ulVn/nLRgsozXsB1oQ7wsWFUrhSjilICKEl1MIkleythkhU8pcD71g5RLr437F259gtixyijDszFoulurgd3vKAzILbw5r6C89ateGLIw9iuk63zsg8O0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727624165; c=relaxed/simple;
	bh=KKAjp3bMyq2nzRJpAuAW+teOZNaNGrgqCdevrix1rDc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FOYM/SBUAy+60k97acdfjM9HsFPW/OBE0eW5q4UEcIF2k04V41dC5iVz9+eTKKAsulddCUjfSLHzuk2TkX5uE121Dt/npGfkpmTO9lBMP6kB5uVm1DgJG8va6PNTANSZ1nOq43A4rdEOcfLNUbg6q/aXiyCmb6Mka3NOTagUbxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=MqK4WKCz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727624128; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dkxPUfYIux4U5bxnPX0bq90205qwFEwHXhxG70+5lDODtO46XJ3zOD0CLKvyTUp8i3qtqVkqcyjHYvV/ZBuyiX6E4d4USay14CJctFFN9y2kcld41WoDXYP/v3G0AZantTWi8q78Zv2sf25ZMOEQulQziJXa8dhm+OCJss9zEwY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727624128; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KKAjp3bMyq2nzRJpAuAW+teOZNaNGrgqCdevrix1rDc=; 
	b=I4LfIq/aitg2AUQbx1HF4RjDx6cHYYudrObeFvTTsQVzP4feNlG+IjDsG85JfMc91CugfbQMRTEVZWg7kFWCmm76L24xT+sM+wE8UF8pD6Jqw2OLdRufjYUx49rD4C7iVk6iJIP8OrRnJEWETkwrEvA7nbA/+Gbgj6RCTtQVRaw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727624128;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=KKAjp3bMyq2nzRJpAuAW+teOZNaNGrgqCdevrix1rDc=;
	b=MqK4WKCziw/o8FJvjKBf/oBxg1pfyBv6wikN3bYKs7zUVtc1LBXCUwK7K39noHKq
	WOGtNKdM3E0rgHkF+vIFikq1SC55CY0Dl80jRv4fIRFZ8b3vl4IGAKTl7OGe8FY+GBD
	Wb1/Au5KXVA0027ezg/e7uCPnbko4j05toMvrkKg=
Received: by mx.zohomail.com with SMTPS id 1727624126111466.10034298979076;
	Sun, 29 Sep 2024 08:35:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH 1/2] device: rust: change the name function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAM_RzfavjM9VPJhTi1czOSC0BFOc3FUHRMdzFrU9fJE+WJMKbw@mail.gmail.com>
Date: Sun, 29 Sep 2024 12:35:09 -0300
Cc: rafael@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,
 aliceryhl@google.com,
 mcgrof@kernel.org,
 russ.weight@linux.dev,
 dakr@redhat.com,
 a.hindborg@kernel.org,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <32476CD7-74D6-4575-9D93-2FBCD5AE3E10@collabora.com>
References: <CAM_RzfavjM9VPJhTi1czOSC0BFOc3FUHRMdzFrU9fJE+WJMKbw@mail.gmail.com>
To: =?utf-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-ZohoMailClient: External

Hi Guilherme, welcome to the community!

The commit message needs some work IMHO. In particular, links may become =
stale,
so please do not link to anything.

It=E2=80=99s also written in first person and in a verbose way, which is =
not good.
Just describe what you did and why the change was necessary succinctly.

You can find some more tips at
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Lastly, I can=E2=80=99t see a diff anywhere. Make sure everything you =
send can
actually be applied and *at least* compile-check your changes. =
Submitting
patches that do not apply and/or do not compile can make people lose =
interest.

Send a v2 with the fixes above and we can start to actually discuss your =
code.

BR

=E2=80=94 Daniel=

