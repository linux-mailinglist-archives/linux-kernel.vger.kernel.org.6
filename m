Return-Path: <linux-kernel+bounces-544759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73AA4E4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A8719C1893
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1DA27F4D8;
	Tue,  4 Mar 2025 15:39:21 +0000 (UTC)
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D028D0A7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102760; cv=fail; b=mrIaZpPp3/BGqaA32adwiPHnjgj13DuBxZ2ocGvgn4shWZWci1rRxHFCr3wKOx+CAvRZVvF65H3YK/ejK/lmQcZde6HrMhtfQyjSTrcJWOjNg9vT38D+9oz8abZ1QAze7S7TGnkIdmaf3gCb5inzbpWqJwGy7kB5On8N/Z+tQvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102760; c=relaxed/simple;
	bh=ukMmycrlCX4XnuJ84GlwrO3VR8S2ECpTiWnIlv8PNd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9MQnU9QefH1fTR9LoNrB9cF32NGC9YZImVm9MjL0/8FCrbWaGjvVuuFdUTHJfTJdF+Q3+aKYqpVX4/RA4KziKTEBgyyDG5uP6suaPoIaMNPljLedjXHvrZ9CllGFJWIaBRtusoqu8iXiuqXfDy01Q3TCKkaoSZSJ+WCcF7YVPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id A5AED40CF4D4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:39:17 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6ftH2bt4zG0sG
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:36:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 81C324272B; Tue,  4 Mar 2025 18:36:33 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541385-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 81E33430A2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:36:29 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id BF05A305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:36:28 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA37AA950
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D61F3FEC;
	Mon,  3 Mar 2025 10:32:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A41E7C32
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997933; cv=none; b=mRslhluF18N7rF6Iqkj9PywEIz/f3Rw5mw7GgYV0WpMrWo0i8gcS2SqHtLdqR2VWWuGGhcrr0KVrtPvjtWZcX5BLhbPfW5fxcLgrWFX11rlu7T+m2rEaH0+at3ZgltO12k/k6avcdO+ftUBIJoaSoW2YVMH/KR6KdGh+e3jvtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997933; c=relaxed/simple;
	bh=cfjZTAA3wFI4kmuYmgNO61aNSEGKpej4JaJFeqP9wPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXr1lvISF0TyFeYDeX6gdcefVab/U3WS0qaO+ST5+MwSKfPuZWJlbLO9CL3S6LyTt1J/1aqPUNVQ94eka8MRGSdPyBs54KyfFk4N0TdjmQ0DU6zO9BkFvq18Q66Xe/dVHN6P+pIvQshkTIwBjNujYpfHCs6sBaxMXcJWD61twhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092C1113E;
	Mon,  3 Mar 2025 02:32:25 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AC8F3F66E;
	Mon,  3 Mar 2025 02:32:03 -0800 (PST)
Date: Mon, 3 Mar 2025 10:32:01 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, suzuki.poulose@arm.com,
	catalin.marinas@arm.com, will@kernel.org, joro@8bytes.org,
	jean-philippe@linaro.org, mark.rutland@arm.com, joey.gouly@arm.com,
	oliver.upton@linux.dev, james.morse@arm.com, broonie@kernel.org,
	maz@kernel.org, david@redhat.com, akpm@linux-foundation.org,
	jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com,
	jsnitsel@redhat.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250303103201.GD13345@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <b46dc626-edc9-4d20-99d2-6cd08a01346c@os.amperecomputing.com>
 <43732270-8fd0-4a18-abec-096e383a6a4d@arm.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43732270-8fd0-4a18-abec-096e383a6a4d@arm.com>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6ftH2bt4zG0sG
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707456.82941@Rs2Sgh524KW6c3pgPLVuCg
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 10:17:28AM +0000, Ryan Roberts wrote:
> On 01/03/2025 01:32, Yang Shi wrote:
> >=20
> >=20
> >=20
> > On 2/28/25 10:24 AM, Miko=C5=82aj Lenczewski wrote:
> >> For supporting BBM Level 2 for userspace mappings, we want to ensure
> >> that the smmu also supports its own version of BBM Level 2. Luckily,=
 the
> >> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DD=
I
> >> 0487K.a D8.16.2), so already guarantees that no aborts are raised wh=
en
> >> BBM level 2 is claimed.
> >>
> >> Add the feature and testing for it under arm_smmu_sva_supported().
> >>
> >> Signed-off-by: Miko=C5=82aj Lenczewski <miko.lenczewski@arm.com>
> >> ---
> >> =C2=A0 arch/arm64/kernel/cpufeature.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7=
 +++----
> >> =C2=A0 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
> >> =C2=A0 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3 +++
> >> =C2=A0 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h=C2=A0=C2=A0=C2=A0=
=C2=A0 | 4 ++++
> >> =C2=A0 4 files changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpuf=
eature.c
> >> index 63f6d356dc77..1022c63f81b2 100644
> >> --- a/arch/arm64/kernel/cpufeature.c
> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> @@ -2223,8 +2223,6 @@ static bool has_bbml2_noabort(const struct
> >> arm64_cpu_capabilities *caps, int sco
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> -
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (scope & SCOPE_LOCAL_CPU) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We are a h=
ot-plugged CPU, so only need to check our MIDR.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we=
 have the correct MIDR, but the kernel booted on an
> >> @@ -2232,10 +2230,11 @@ static bool has_bbml2_noabort(const struct
> >> arm64_cpu_capabilities *caps, int sco
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we ha=
ve an incorrect MIDR, but the kernel booted on a
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * suffi=
cient CPU, we will not bring up this CPU.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return cpu_has_bbml2_noa=
bort(read_cpuid_id());
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu_has_bbml2_noabo=
rt(read_cpuid_id()))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return false;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0 -=C2=A0=C2=A0=C2=A0 return false;
> >> +=C2=A0=C2=A0=C2=A0 return has_cpuid_feature(caps, scope);
> >=20
> > Do we really need this? IIRC, it means the MIDR has to be in the allo=
w list
> > *AND* MMFR2 register has to be set too. AmpereOne doesn't have MMFR2 =
register set.
>=20
> Miko, I think this should have been squashed into patch #1? It doesn't =
belong in
> this patch.

Yes, 100%. Missed this, will put into patch #1.


