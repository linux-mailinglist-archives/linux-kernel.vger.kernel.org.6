Return-Path: <linux-kernel+bounces-260015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A436893A156
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB801F23292
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE991534EC;
	Tue, 23 Jul 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LqGt6uc9"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6C1514DA;
	Tue, 23 Jul 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741272; cv=none; b=JcAN2iWZkJHNBi/gA9k/hCQqx0EyTwEVNXeRrnCwoiTFOBUP3YCd3YhU49R2eqEY4U31jkSqgq3G5goqcqmkip7bcFgSwU+RBPOCHABpRDTmFznMSffeU4BPHU3vzE7Je+YcAqDTl5DrqUW+1rTcx5M6xehCN8tJ/JvvTgetFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741272; c=relaxed/simple;
	bh=wLN/Yjw8usP9RnuSqHJm4kmNonhPo0cW+GVQCrhFtG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeZNBwABHZk6pkDpe3rrpu4tJ13jhrpf2oNtp7JYsb2Lbo7FgynSj+EdFwwKxR2ER0RfluSYRLXaYb4H8u/vBhSX4CqF2DtQFFnkKWqNcCAsUaSDvYLlflB8qBGqHrAjiPScHDDTMI6a0LaKA8ijRrBke3BT9jq/8QK+YDBzy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LqGt6uc9; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721741263; x=1722000463;
	bh=wLN/Yjw8usP9RnuSqHJm4kmNonhPo0cW+GVQCrhFtG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LqGt6uc9qmOgwlb8XluF6NUshBEiRLAxX2BGBeTHqu254KFOlqRSlnFDJQk69kSQl
	 7ePm0zlQntrpTF3EnShxlZ/pVdiN/23B/jfCLNFy0xUU8287AIliT7Zr/UV3unGyOR
	 Eg9WRJ1NVsuhyFHCZNXsRp/c7j4k5SKFyzskWPza60MM4+loXoWeClBO7+yX05ODKG
	 p2h8ObM1g9xBOWZ1Ks1j0C+gg1qNKoG4ismzDsu3pXVbZBW+8U++X7duz4XmvLymP/
	 oj00ooInvmC0T6hIlriOxKra13A3V2Kukn9oiPwIywlgkvDFuub5vboU+3wM+V8cFf
	 cB51ioy5Tis+A==
Date: Tue, 23 Jul 2024 13:27:39 +0000
To: raymondhackley@protonmail.com
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, nikita@trvn.ru, phone-devel@vger.kernel.org, robh+dt@kernel.org, stephan@gerhold.net, ~postmarketos/upstreaming@lists.sr.ht, Juan-Rafael Fernandez <jrfern@proton.me>
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-rossa: Add touchscreen
Message-ID: <20240723132705.1832-1-raymondhackley@protonmail.com>
In-Reply-To: <20240723131441.1764-1-raymondhackley@protonmail.com>
References: <20240723131441.1764-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
X-Pm-Message-ID: 57867d9b0b0de10c95e0902eccadfef40b27b69c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tested-by: Juan-Rafael Fernandez <jrfern@proton.me>

Regards,
Raymond


