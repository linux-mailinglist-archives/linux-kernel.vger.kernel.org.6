Return-Path: <linux-kernel+bounces-432017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE39E43CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E62A1647B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D191C3BE4;
	Wed,  4 Dec 2024 18:53:13 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24F1A8F97
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338392; cv=none; b=V1Kug3uqGsUSq3HeQkWy86jCZucPZCU7/96r4WdbCGYS5B99dUqwB15c1cVlQVW4G1jGjZ3T23VZ0XSxRFkDch/xJvXq4AtjMrDRZ5V8XwSw8/hgTntCGQP8cGkt0+MLvSGTigtKipqjpU84y5NDIMEqMRP6x1iRx5NojOb6oCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338392; c=relaxed/simple;
	bh=5m0M7F9A85L0in+vQnBG9abJrYWf+6uew75LWLb5Xfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPQV827wJnbNgZlQnTKAAkVfkHO5J9RBKeQ70ig9IRm2g5ms4TUowqZQOPXFIqeZyUFgZptEfpMOZgdHCAiWjWS3Z2VUV8Ycorcl7GDd44n7G/WO8UF8BRUAkpyxUOr0mustQ0zVNN3BpX488m3aaUBOc5Wezxao1SbnXfwWM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 3A22872C97F;
	Wed,  4 Dec 2024 21:53:09 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 2915C36D0178;
	Wed,  4 Dec 2024 21:53:09 +0300 (MSK)
Date: Wed, 4 Dec 2024 21:53:09 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Will Deacon <will@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <20241204185309.v4yq6n7antt7m7jb@altlinux.org>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck>
 <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org>
 <86ser6t6fs.wl-maz@kernel.org>
 <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
 <20241203092721.j473dthkbq6wzez7@altlinux.org>
 <1847e34fa7724d28aeb22d93752f64f2@huawei.com>
 <20241203221453.mwh6sozyczi4ec2k@altlinux.org>
 <87jzcfsuep.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87jzcfsuep.wl-maz@kernel.org>

Marc,

On Wed, Dec 04, 2024 at 08:51:26AM +0000, Marc Zyngier wrote:
> On Tue, 03 Dec 2024 22:14:53 +0000,
> Vitaly Chikunov <vt@altlinux.org> wrote:
> > 
> > I tried to verify that MPAM is advertised with qemu+gdb method, as
> > suggested by Oliver, but ID_AA64PFR0_EL1 register is not there.
> > 
> >   (gdb) i r ID_AA64PFR0_EL1
> >   Invalid register `ID_AA64PFR0_EL1'
> 
> Then there is a bug in either QEMU or the GDB stubs. This register
> exists, or you wouldn't be here.
> 
> > 
> > Are there other suggestions?
> 
> Mark has described what the problem is likely to be. 6.6-stable needs
> to have 6685f5d572c22e10 backported, and it probably should have been
> Cc: to stable. Can you please apply the following patch to your *host*
> machine and retest?

Looks like I will be able to test this.

Thanks,

> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 370a1a7bd369..258a39bcd3c7 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1330,6 +1330,7 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
>  			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
>  
>  		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
> +		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MPAM_frac);
>  		break;
>  	case SYS_ID_AA64ISAR1_EL1:
>  		if (!vcpu_has_ptrauth(vcpu))
> @@ -1472,6 +1473,13 @@ static u64 read_sanitised_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
>  
>  	val &= ~ID_AA64PFR0_EL1_AMU_MASK;
>  
> +	/*
> +	 * MPAM is disabled by default as KVM also needs a set of PARTID to
> +	 * program the MPAMVPMx_EL2 PARTID remapping registers with. But some
> +	 * older kernels let the guest see the ID bit.
> +	 */
> +	val &= ~ID_AA64PFR0_EL1_MPAM_MASK;
> +
>  	return val;
>  }
>  
> @@ -1560,6 +1568,29 @@ static int set_id_dfr0_el1(struct kvm_vcpu *vcpu,
>  	return set_id_reg(vcpu, rd, val);
>  }
>  
> +static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
> +			       const struct sys_reg_desc *rd, u64 user_val)
> +{
> +	u64 hw_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> +	u64 mpam_mask = ID_AA64PFR0_EL1_MPAM_MASK;
> +
> +	/*
> +	 * Commit 011e5f5bf529f ("arm64/cpufeature: Add remaining feature bits
> +	 * in ID_AA64PFR0 register") exposed the MPAM field of AA64PFR0_EL1 to
> +	 * guests, but didn't add trap handling. KVM doesn't support MPAM and
> +	 * always returns an UNDEF for these registers. The guest must see 0
> +	 * for this field.
> +	 *
> +	 * But KVM must also accept values from user-space that were provided
> +	 * by KVM. On CPUs that support MPAM, permit user-space to write
> +	 * the sanitizied value to ID_AA64PFR0_EL1.MPAM, but ignore this field.
> +	 */
> +	if ((hw_val & mpam_mask) == (user_val & mpam_mask))
> +		user_val &= ~ID_AA64PFR0_EL1_MPAM_MASK;
> +
> +	return set_id_reg(vcpu, rd, user_val);
> +}
> +
>  /*
>   * cpufeature ID register user accessors
>   *
> @@ -2018,7 +2049,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_ID_AA64PFR0_EL1),
>  	  .access = access_id_reg,
>  	  .get_user = get_id_reg,
> -	  .set_user = set_id_reg,
> +	  .set_user = set_id_aa64pfr0_el1,
>  	  .reset = read_sanitised_id_aa64pfr0_el1,
>  	  .val = ID_AA64PFR0_EL1_CSV2_MASK | ID_AA64PFR0_EL1_CSV3_MASK, },
>  	ID_SANITISED(ID_AA64PFR1_EL1),
> 

