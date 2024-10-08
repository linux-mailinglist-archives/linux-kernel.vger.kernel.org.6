Return-Path: <linux-kernel+bounces-355530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A105995390
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D821C25651
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6021E04B7;
	Tue,  8 Oct 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mULsRLzl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BW7f9OAl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59F1DF27C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402267; cv=none; b=Ziw3JvXyREtARfrpSpmyGJaoJuXpZbB671ajj0grN5aaaXgNfxDpnC4QBAMM7o/VlnKL4TW+QdEjoghjQk5rW4vileRJxUW8+o2LO/VulNCUGAg2Rz8VcL0P24vW4dAB5z4srg7gNOng2j/YImLou7ETrRUbtM1RwxlDWyM85LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402267; c=relaxed/simple;
	bh=6WHc8l5PXiXyl+BCglLihi2gw5Q/FBDZdw0prfcRlck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/qmsOYhU9vpnvlKYRpeQiZ9EZyS0586KQuA6EMqRRDcmqrYY/jNcWfm5FSoZ/K9FqY9Kme8ohJdY5wZWlX/noht3fnBgojp64fzewmcoptyT0mT1BNGlLRX5dnhJjCfD1tem3rlHWV/jaJ/j/V2WETk50EVyQ9AIZURgGNBkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mULsRLzl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BW7f9OAl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Oct 2024 17:44:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728402263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki/Pm8DAl/VsGvfQevprKrdSizkHUE7BtC51sJT0UL0=;
	b=mULsRLzlVO/2gPKHcHPooEqXsvCde8R0N9EnuYHEUVv1l0UlR5mvUezWfQT8eFhwdhmHuq
	Yf2BpSbob1iTkJImsoETiuGGMR6zMMh+SNpOTAwRX7Jdy/qU3wOMOHm1pydvMjt0YnWJl5
	TzzEaHRgjTOnJL00GSOzQsTR8ZvqHsn9TgjMjywARetkA7Yl990Zo2HYAQ3YdB+LypU/09
	BECaAsMLmvhc80/W7uO/vlU6NyDy3zeapyz2EcUFQBUO/zxdhfXHemdaprjDKii5nlicOp
	mhvQuxZzdk05Ihf8mupXhD3f7n6zDx2ddO3MdAdGMdmG35HB+4nW3KjmOvGezQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728402263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki/Pm8DAl/VsGvfQevprKrdSizkHUE7BtC51sJT0UL0=;
	b=BW7f9OAlqLl2hIfIk03b6exdcPSoCF9PWwNuMwqokDL2fu61XWQYjDaGjBcMQZhjcpvUjY
	eLsRi6UgwPr/feCw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86-cpuid@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] x86-cpuid-db: Release v2.0
Message-ID: <ZwVTVO2FcH95WFBp@lx-t490>
References: <ZwU0HtmCTj2rF2T8@lx-t490>
 <55f755e9-2712-47d5-82d5-d6e685969461@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55f755e9-2712-47d5-82d5-d6e685969461@citrix.com>

Hi Andrew,

On Tue, 08 Oct 2024, Andrew Cooper wrote:
>
> On 08/10/2024 2:31 pm, Ahmed S. Darwish wrote:
> > to:
> >
> >     /*
> >      * Leaf 0x0
> >      * Maximum standard leaf number + CPU vendor string
> >      */
> >
> >     struct leaf_0x0_0 {
> >         ...;
> >     };
> >
> >     /*
> >      * Leaf 0x7
> >      * Extended CPU features enumeration
> >      */
> >
> >     struct leaf_0x7_0 {
> >         ...;
> >     };
> >
> >     struct leaf_0x7_1 {
> >         ...;
> >     };
> >
> > Overall, this removes ambiguity for IDs like 0x16, and improves kernel
> > code greppability (x86 PQ pending).
>
> So what does leaf 0xd with 62 subleaves look like.  Do we really have
> one number in hex, and one in decimal?

Hmmm, good point...

For now, if we grep the generated C linux header for all the structures
that are not subleaf 0, we get:

    $ grep -E 'struct leaf_0x[0-9a-f]+_[^0]' cpuid-bitfields.h

    struct leaf_0x7_1 {
    struct leaf_0x7_2 {
    struct leaf_0xd_1 {
    struct leaf_0xd_2 {
    struct leaf_0xf_1 {
    struct leaf_0x10_1 {
    struct leaf_0x10_3 {
    struct leaf_0x12_1 {
    struct leaf_0x12_2 {
    struct leaf_0x14_1 {
    struct leaf_0x17_1 {
    struct leaf_0x1d_1 {
    struct leaf_0x23_1 {
    struct leaf_0x23_3 {
    struct leaf_0x80000020_1 {
    struct leaf_0x80000020_2 {
    struct leaf_0x80000020_3 {

We do indeed have an encodings for leaves with large dynamic number of
valid subleaves, through "array=":

    darwi@lx ~/x86-cpuid-db (main)> git grep array=

    db/xml/leaf_04.xml:  <subleaf id="0" array="32">
    db/xml/leaf_0b.xml:  <subleaf id="0" array="2">
    db/xml/leaf_0d.xml:  <subleaf id="2" array="62">
    db/xml/leaf_10.xml:  <subleaf id="1" array="2">
    db/xml/leaf_12.xml:  <subleaf id="2" array="30">
    db/xml/leaf_17.xml:  <subleaf id="1" array="3">
    db/xml/leaf_18.xml:  <subleaf id="0" array="32">
    db/xml/leaf_1b.xml:  <subleaf id="0" array="32">
    db/xml/leaf_1f.xml:  <subleaf id="0" array="6">
    db/xml/leaf_8000001d.xml:  <subleaf id="0" array="32">
    db/xml/leaf_80000026.xml:  <subleaf id="0" array="4">

But the generators don't deal with that (yet), and that's why they're
also not in the generated CSV/header files.

I'm going through the Linux x86 PQ now, so it's a nice opportunity to
see how something like "struct leaf_0x0_0x0" looks within the rest of
the kernel code...  I'll also ping Thomas to see if he has any feedback
on the topic.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

