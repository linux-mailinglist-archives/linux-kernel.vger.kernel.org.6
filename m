Return-Path: <linux-kernel+bounces-524033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9B4A3DE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7557770115B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09CA1FCCF8;
	Thu, 20 Feb 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="Tm3Ih817"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E91FCCF7;
	Thu, 20 Feb 2025 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064726; cv=pass; b=i6Bps7/ewGXWCx0xLTDSB7hEyusIiFCywlNGYaB84Vj1m4beTgUhpdwF/XA4fF+8s9LcD8Y/FNLi+oXTh9IXpBAhNlDiLcxFNu9imj8aoFl52ShBmqLcOl6qznVtlvCCMEcZQoCKq5QokUT+bKODyd6pPEAOSk9poJ03Gn7zr5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064726; c=relaxed/simple;
	bh=mZjeVny1wTdEsQOGHmI6uUbAFXvuL+TGGMXqWzQ6jrY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tK5iaotb+deiRJHO3ZNhNooM0+fwKehtCC+E6Mv34wu1Uf6Lx+RfUV1hsgy6juGLFb3O+AMa2hwt+B4uQOr2wcsBCfHHcwvnpL7lkWo72YerGX33gDnAiNaAKifXJ6ONpn/1DlMgWQVERkkYCbY8yhtg0yJ+QZ1kyuPzBytsT48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=Tm3Ih817; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1740064707; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G/+dFvnYow67mmuUuLmRTYnzf6UeEIMw8b5heJkP4yhg3VI6Wu8itHtlVT0f5k3+zvz6rqK0Io35WWf5tI4GFPryqGxtXO7jtKuxtCSWutpwCW21mKkVRg1hcUIsTd37Rxb0eKMltcrrpTFLj/MbtNUHVjlmk7NOC7vIBA0bQWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740064707; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Rp+rVrfDMPBn3/xNGZmxdi46SYzFWH1AX8BoNcE1XA0=; 
	b=Yy+LJKb/1msFvFhDj8GqLA68hmVvFY/WsePiNwCl5IJagiF2Dc96D1vj6AZh0zEOK5zSQGE3CLMNFOo3IjRJ3B06dQpmOofIhqy2F8AjAuNloQin/mFhhpmte4KKxJ/feh1szHXAabI813qmYg7SkN5axm5eL3+7TGitdAPKiSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740064707;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Rp+rVrfDMPBn3/xNGZmxdi46SYzFWH1AX8BoNcE1XA0=;
	b=Tm3Ih817EF7OdQgMv4PkGMP1Csn/XNibSQDOb+A15sNgloOSubjDB42opo25nxhM
	niz7P2bUgYooZmsGEN6ULxEkXw7mheRM2bqwzzmLyMyMSOtj8dW6aWnTkagaDZZo+hG
	cErNTk0Tixqbmjqo5yedIwORuTC8M5ecdaR/buw4=
Received: by mx.zohomail.com with SMTPS id 1740064703309170.8682384978547;
	Thu, 20 Feb 2025 07:18:23 -0800 (PST)
Message-ID: <c76655ad-e1e4-46f1-aecd-e57716b80ee7@zohomail.com>
Date: Thu, 20 Feb 2025 23:18:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] clk: canaan: Add clock driver for Canaan K230
From: Xukai Wang <kingxukai@zohomail.com>
To: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
 <20250217-b4-k230-clk-v4-2-5a95a3458691@zohomail.com>
 <3fb73691f50e599c361dddaff08d3af5.sboyd@kernel.org>
 <364a8fbd-d78e-421d-a37b-cb7a29077802@zohomail.com>
Content-Language: en-US
In-Reply-To: <364a8fbd-d78e-421d-a37b-cb7a29077802@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227b37c3d6cd7e77c464d706fea00008745026a1b51981f499518d14f3b24d3e15b70bb1178a690aa:zu080112272a2a88529145200e7fbbfe31000028805d1bb7a5f5248ffafce1771786117a59a676dbc0a667bb:rf0801122b9b232d296b2f5180ec561dd000007b4222c2519ad0007ac17d0ec5cfeaeb0f78e4f36397161f115294f8ae:ZohoMail
X-ZohoMailClient: External


On 2025/2/20 23:07, Xukai Wang wrote:
> On 2025/2/19 05:48, Stephen Boyd wrote:
>>> +static void k230_clk_disable(struct clk_hw *hw)
>>> +{
>>> +       struct k230_clk *clk = to_k230_clk(hw);
>>> +       struct k230_sysclk *ksc = clk->ksc;
>>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>>> +       u32 reg;
>>> +
>>> +       if (!cfg->have_gate) {
>>> +               dev_err(&ksc->pdev->dev, "This clock doesn't have gate\n");
>> Why are the clk_ops assigned to this clk then?
> If this clock doesn't have a gate, then the clk_ops will not be assigned to it. In this case, I'm simply checking it again. You can verify this in the k230_register_clk function to ensure it's handled correctly.
Apologies for my script doesn't wrap this paragraph.
> If you think this check is redundant, I can drop it.

