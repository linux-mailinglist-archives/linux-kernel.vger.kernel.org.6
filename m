Return-Path: <linux-kernel+bounces-430935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FD9E3764
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A447F28410F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE31ADFF8;
	Wed,  4 Dec 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bjm6oNMm"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213518595B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307754; cv=none; b=aOlHNO09SXnX5RKiDKIUlzzAUJjeVYmhM0JHKM/btUnmfb8RlncrIIO+cT70KW0qWFPclPSSyOO04767iiorAb356hQiB5fdjeF7IPI7GR4SKNp2k9EKYx6prUwyWMwAe4sXn+XMZrvbq2aWfWMWgAggWKLpCG1ikT3O3CTf5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307754; c=relaxed/simple;
	bh=6ir4ur4ALELUs+muOZsZYxJvjzewt8CcsnU0ewJuFNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3kc9KXc91ouou4Wg15/v+1b4XEaQjiQOGBEvPLsWkbIPULKEHe/K4Guq9QDHLTGrrDKnWdNxvibYyQ7dZsubR/8M9I6cC1Xj5/icKB1C/JKVbS5+jQCdWHnctpVjzkX7MobikJ9wjuvbQFJCc0NwOVQAL+O9qfr4m7hTXnh5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bjm6oNMm; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F73C2000C;
	Wed,  4 Dec 2024 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733307750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ir4ur4ALELUs+muOZsZYxJvjzewt8CcsnU0ewJuFNo=;
	b=Bjm6oNMmDQEv7TTam2kw81UN2wwq0tdgkVlpyRLXNqsyEHLpfXCxeoHwOg7DDTa1aeJzst
	q+Djot8sLmnVh8UGgsRa1kPfnysDmIECVVP27iriJjnEL34u0Tf/9Xyoi2zmos5gUhbdmQ
	6JwIW/lIdfbTNe5OKYY/r7/sutBQU7NDNC/t5b9AFp9RjtSmLgFuYUJ3i7OBQHikvo4fky
	XrB4zFYrQjN8txQVsrz/Phs26+1IjZrEcK/jne3y9WmUJCBQ+Dek9il9khx5Q7Iy5BUzQU
	2uu5+iinMfL4A373nmH2WE6Hk35DR68yi1fgtKYKKTbnel0o+HqRLVBgD8Mp/g==
Message-ID: <8b5934f6-96df-47f4-aad6-50b2308d9fe9@bootlin.com>
Date: Wed, 4 Dec 2024 11:22:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mux: mmio: Add suspend and resume support
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com
References: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 9/11/24 10:53, Thomas Richard wrote:
> The status of each mux is read during suspend and stored in the private
> memory of the mux_chip.
> Then the state is restored during the resume.

Hello again Peter,

Do you have any comments ?
If not, is it possible to get this patch merged ?

Best Regards,

Thomas

