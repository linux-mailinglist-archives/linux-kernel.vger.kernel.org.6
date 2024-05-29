Return-Path: <linux-kernel+bounces-193697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED04D8D30C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74E928D071
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A2181302;
	Wed, 29 May 2024 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b="l1H22dlh"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870F169378
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970088; cv=none; b=miqOAJG5bTNmgLC3nG9dShtWb2BooUeBTkNSfOqMYIe0dgwy047OZqWTmOsVDG4q1wu2jk04MDlmke/We2UsEhZ6KykfBk7Jdpg2l2fA4lO3kJ+lR0qADjSy7snRGj2qQ8zxGg6hc54s/MXsS9G0keNeVVifDq2MCQ2EX5qvJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970088; c=relaxed/simple;
	bh=cEDMoowbFZ5WktBarZHf81BOCA+EdPpdc+vCtp4npVA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxb1axeNXVRcWbCEUOzJyOj4SSAQMO6SIgqHu3nwh3GzjBSIBKkhiTFB4ZVuI9imRlEhYFD7jEyK7BU25Q4SCDL3jviEcU7hNgRGVXzejs94j/24koWIEPlFSo0EzoLVvdmVQLvXozDQHwXwCm37uxnJiRXPaAgLpIood3HgrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com; spf=pass smtp.mailfrom=hughsie.com; dkim=pass (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b=l1H22dlh; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hughsie.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hughsie.com;
	s=protonmail; t=1716970075; x=1717229275;
	bh=CdCU+zkzWxCVkvGAtdPb8KGBuUMK2qab8ruKLWcSQkU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=l1H22dlh9G2aQxhS4mro1rTr27SBJoo2HZXWI+WaV3YL2E4yjyR2soU5dKC6QYDFX
	 kgNxrIAmInDeJ6n2nKyFIqlkZDvo3PCdc37mGc+VF23FhLz4io8azvIp3SktxiDeOA
	 dIKRsPQayR5p9cslX8hl+lSHCbCogEi1ZzTyvnXG8h8jTf0upLK31xa3fUCfzqi2b5
	 Vzi4tBeoZkfYrQRbdrxieA4urgEZaBLbKL4OSTrPzsEPTFLe15QSdYh5HqQOOP/36f
	 iyF2tiX+xRdmXwzi9gBr6KYk7S5bVZM4qE0bUhEi75zk+fHHnG61qZnKQ3a08ry7u5
	 kEW7Mcy0BztYA==
Date: Wed, 29 May 2024 08:07:52 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: Richard Hughes <richard@hughsie.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Tom Lendacky <thomas.lendacky@amd.com>, "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..." <linux-crypto@vger.kernel.org>, Richard Hughes <hughsient@gmail.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Enable PSP security attributes on more SoCs
Message-ID: <oCZE3H8ZnqlQsatOdb4HH7_0t7E9fsRqVv1QodA3IeUSDCdx9DP1bWsLOVq6T5iGffMjzMequirUJSM4UpcA1y2LZVUvMsffulaArsPy2cs=@hughsie.com>
In-Reply-To: <20240528210712.1268-1-mario.limonciello@amd.com>
References: <20240528210712.1268-1-mario.limonciello@amd.com>
Feedback-ID: 110239754:user:proton
X-Pm-Message-ID: 0a0f6f13a6a6f7ccd86427b6e79c68dcfbe63ade
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 28th, 2024 at 10:07 PM, Mario Limonciello <mario.limonciell=
o@amd.com> wrote:
> v1->v2:

Looks great, and the output of "fwupdmgr security" on my pre-production Len=
ovo T14 (AMD Ryzen 7 PRO 4750U) is now a lot more accurate:

 HSI-1
 =E2=9C=94 BIOS firmware updates:         Enabled
+=E2=9C=94 Fused platform:                Locked
+=E2=9C=94 Supported CPU:                 Valid
 =E2=9C=94 TPM empty PCRs:                Valid
 =E2=9C=94 TPM v2.0:                      Found
 =E2=9C=94 UEFI bootservice variables:    Locked
 =E2=9C=94 UEFI platform key:             Valid
=20
 HSI-2
 =E2=9C=94 IOMMU:                         Enabled
+=E2=9C=94 Platform debugging:            Locked
 =E2=9C=94 TPM PCR0 reconstruction:       Valid
+=E2=9C=98 SPI write protection:          Disabled
 =E2=9C=98 BIOS rollback protection:      Disabled
=20
 HSI-3
+=E2=9C=98 SPI replay protection:         Not supported
 =E2=9C=98 CET Platform:                  Not supported
 =E2=9C=98 Pre-boot DMA protection:       Disabled
 =E2=9C=98 Suspend-to-idle:               Disabled
 =E2=9C=98 Suspend-to-ram:                Enabled
=20
 HSI-4
+=E2=9C=94 Encrypted RAM:                 Encrypted
 =E2=9C=94 SMAP:                          Enabled
+=E2=9C=98 Processor rollback protection: Disabled

Tested-by: Richard Hughes <richard@hughsie.com>

Richard

