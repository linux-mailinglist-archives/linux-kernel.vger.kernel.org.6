Return-Path: <linux-kernel+bounces-435623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF51D9E7A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C06284ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF14201110;
	Fri,  6 Dec 2024 20:56:14 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A22A1C549C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518573; cv=none; b=hqUhuufAs7XUMOs1JeXPycL60pSss3tew0qzXaXtJVAUA/+MITe8x5yyE8h+IYmW6NRBkkTH/cMoizmBJEBqNOEE7HoCgm9O1I1Sv+mi7bl8qJMl3H+oOPPQ+yEj6TgLn5NZqECEqjKwLRAJrPDjanAKBwDQnM8lkuDi8pbsZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518573; c=relaxed/simple;
	bh=mt3uQMjIJegXRUUe8GNoBFdgTDrmJP3DFaXZp0HIwlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cesAjZvOUhfmHwnhMTpep15W7QYMb4PyElH3xUJbfdAot0/XCmxtTxsoK779FMuQFi8nEj979YR93glGIO2Gv8OgDhjIrsZO4yOJ+c22zzFbdIKvOiXweDmIX1NcWDaNgd1IV4FL7xNTykuqGGhpZHdJlWGjhduqQTf2n8kiwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 72C3772C981;
	Fri,  6 Dec 2024 23:56:02 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 615C236D0178;
	Fri,  6 Dec 2024 23:56:02 +0300 (MSK)
Date: Fri, 6 Dec 2024 23:56:02 +0300
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
Message-ID: <20241206205602.7phcrxqsv4c6oul4@altlinux.org>
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
> > Shameer, Marc, Oliver, Will,
> > 
> > On Tue, Dec 03, 2024 at 10:03:11AM +0000, Shameerali Kolothum Thodi wrote:
> > > > -----Original Message-----
> > > > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> > > > Behalf Of Vitaly Chikunov
> > > > Sent: Tuesday, December 3, 2024 9:27 AM
> > > > To: Marc Zyngier <maz@kernel.org>
> > > > Cc: Will Deacon <will@kernel.org>; james.morse@arm.com; linux-arm-
> > > > kernel@lists.infradead.org; Catalin Marinas <catalin.marinas@arm.com>;
> > > > linux-kernel@vger.kernel.org; oliver.upton@linux.dev;
> > > > mark.rutland@arm.com
> > > > Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
> > > > 0000000002000000 [#1] SMP
> > > > 
> > > > Marc,
> > > > 
> > > > On Tue, Dec 03, 2024 at 01:31:19AM +0300, Vitaly Chikunov wrote:
> > > > > On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> > > > > > On Mon, 02 Dec 2024 15:59:40 +0000,
> > > > > > Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > > > >
> > > > > > > Marc,
> > > > > > >
> > > > > > > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > > > > > > >
> > > > > > > > What the log doesn't say is what the host is. Is it 6.13-rc1 as well?
> > > > > > >
> > > > > > > No, host is 6.6.60.
> > > > > >
> > > > > > Right. I wouldn't be surprised if:
> > > > > >
> > > > > > - this v6.6 kernel doesn't hide the MPAM feature as it should (and
> > > > > >   that's proably something we should backport)
> > > > >
> > > > > How to confirm this? Currently I cannot find any (case-insensitive)
> > > > > "MPAM" files in /sys, nor mpam string in /proc/cpuinfo, nor MPAM
> > > > > strings in `strace -v` (as it decodes some KVM ioctls) of qemu process.
> > > > >
> > > > > >
> > > > > > - you get a nastygram in the host log telling you that the guest has
> > > > > >   executed something it shouldn't (you'll get the encoding of the
> > > > > >   instruction)
> > > > >
> > > > > I requested admins of the box for dmesg output since I don't have root
> > > > > access myself and nowadays dmesg is not accessible for a user.
> > > > 
> > > > This is what they reported:
> > > > 
> > > >   kvm [2502822]: Unsupported guest sys_reg access at: ffff80008003e9f0
> > > > [000000c5]
> > > >                    { Op0( 3), Op1( 0), CRn(10), CRm( 4), Op2( 4), func_read },
> > > > 
> > > 
> > > As Will pointed out I think this is access to MPAMIDR_EL1 and is from this
> > > code here,
> > > 
> > > +++ b/arch/arm64/kernel/cpuinfo.c
> > > @@ -478,6 +478,9 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
> > >  	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
> > >  		__cpuinfo_store_cpu_32bit(&info->aarch32);
> > >  
> > > +	if (id_aa64pfr0_mpam(info->reg_id_aa64pfr0))
> > > +		info->reg_mpamidr = read_cpuid(MPAMIDR_EL1);
> > > +
> > >  	cpuinfo_detect_icache_policy(info);
> > >  }
> > > 
> > > I did manage to boot my setup in 6.6 and this is what happens,
> > > 
> > > Host kernel 6.6
> > > Guest Kernel 6.13-rc1
> > > 
> > > [    0.195392] smp: Brought up 1 node, 8 CPUs
> > > [    0.219000] SMP: Total of 8 processors activated.
> > > [    0.219629] CPU: All CPU(s) started at EL1
> > > ...
> > > [    0.223212] CPU features: detected: RAS Extension Support
> > > [    0.223927] CPU features: detected: Memory Partitioning And Monitoring
> > > [    0.224796] CPU features: detected: Memory Partitioning And Monitoring Virtualisation
> > > [    0.225961] alternatives: applying system-wide alternatives
> > > ...
> > > 
> > > Guest detects MPAM and boots fine.
> > > 
> > > Host kernel 6.13-rc1
> > > Guest Kernel 6.13-rc1
> > > 
> > > [    0.196625] smp: Brought up 1 node, 8 CPUs
> > > [    0.222093] SMP: Total of 8 processors activated.
> > > [    0.222769] CPU: All CPU(s) started at EL1
> > > ...
> > > [    0.226620] CPU features: detected: RAS Extension Support
> > > [    0.227453] alternatives: applying system-wide alternatives
> > > 
> > > MPAM is not visible to Guest in this case.
> > > 
> > > So as I pointed out earlier could it be a case where the ID register reports MPAM support
> > > but the firmware has not enabled MPAM?
> > > 
> > > James seems to be mentioning that case here,
> > > 
> > > " (If you have a boot failure that bisects here its likely your CPUs
> > > advertise MPAM in the id registers, but firmware failed to either enable
> > > or MPAM, or emulate the trap as if it were disabled)"
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

We tested the host with this patch applied over 6.6.63 and 6.13-rc1
guest does not Oops anymore.

I'd suggest this is also get backported to 6.12.y branch.

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
> > > https://lore.kernel.org/all/20241030160317.2528209-4-joey.gouly@arm.com/
> > > 
> > > Is there a way you can find out the BIOS version on that board?
> > 
> > Unfortunately, admins of the server do not provide me with this
> > info.
> 
> This doesn't really help, I'm afraid.
> 
> > For such cases, when MPAM is incorrectly advertised, can we have kernel
> > command line parameter like mpam=0 to override it's detection?
> 
> We could, but only when we can confirm what the problem is.
> 
> > I think with "If you have a boot failure that bisects here" it's
> > acknowledged possibility and it's confirmed by our server.
> 
> Not really. This talks about firmware. We are debugging the hypervisor
> here. This might be closely related, but these are not the same
> things.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

