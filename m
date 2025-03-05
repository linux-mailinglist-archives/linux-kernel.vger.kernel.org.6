Return-Path: <linux-kernel+bounces-546293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBBFA4F8D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BA57A7D75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C31F4194;
	Wed,  5 Mar 2025 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgoVHxWZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF342AAF;
	Wed,  5 Mar 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163463; cv=none; b=kKsRXfwR3/8QXICr7K12wY1A8sikxMgpshyfK+Z/fQvDGLor5TXyBUbVrvm6hBvCJLrBlAGXVNtcEhen3xOfubMq2BjmURXJfBbL5Rx99u3xHCgCLKMyWD76K5vNrPcw3oxXiW8priYXqx3Z+2F0E2hgkFl5g8L5i/7FdgsuhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163463; c=relaxed/simple;
	bh=okDqkVAZeMp5yL7AkuXqwEC+7QyMVjPCqidcSs1o0Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er92fhdFNAZvAWLuYT8rcxXdK0Vc5b8OU7EMn7UjdjMfb8KSD7KgEjDll2+McSifsBiTtPK1CxfW0TaZM504G8BIMylFdCBoij+N/VPhXOS58vGjyqy3ssV6wgLrILNR9KZwQM54IMH/6C8EeSiD9zMTF2dWrLgvq4Tp6YeJpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgoVHxWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9C5C4CEE9;
	Wed,  5 Mar 2025 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741163462;
	bh=okDqkVAZeMp5yL7AkuXqwEC+7QyMVjPCqidcSs1o0Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgoVHxWZza7iBpVfg1WoFHiLOBvm+Hgv7JkLzt3hl/2mNj5J++YVQhV7HbD0D3lGp
	 JeHmz8P6+z9FTM4O1uhD7nzROQMZIrdqjgFb/XxIq6XbKQIwJsQmNd9ian/ZTM5skt
	 JvKjMNSFJqkmILQXVaMzEyEAGTutAHJzbw504Kxpio0nZNRvaCzCJoAJulqPD5A6Js
	 Uf6l5NQSkS0iOb/wmyCevWzf/VPKydhRZIKEmwh5QuKbLk8oOWY3hcvg5FBhrscIx0
	 7Jgzeo7NX0eNCj7h/9JKiyfneofaObIVCzlgFoUi4fd9JKzK9SnVh62U9/uz241Qiv
	 DH44qGi/2wxuw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tpk9Z-000000004XF-1eNj;
	Wed, 05 Mar 2025 09:30:58 +0100
Date: Wed, 5 Mar 2025 09:30:57 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] arm64: dts: qcom: x1e: mark l12b and l15b always-on
Message-ID: <Z8gLwSkMocE-KrbH@hovoldconsulting.com>
References: <20250227081357.25971-1-johan+linaro@kernel.org>
 <e6dc86bb-1dd1-486e-8e3e-18974da6cf86@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6dc86bb-1dd1-486e-8e3e-18974da6cf86@oss.qualcomm.com>

On Tue, Mar 04, 2025 at 06:07:32PM +0100, Konrad Dybcio wrote:
> On 27.02.2025 9:13 AM, Johan Hovold wrote:
> > The l12b and l15b supplies are used by components that are not (fully)
> > described (and some never will be) and must never be disabled.
> > 
> > Mark the regulators as always-on to prevent them from being disabled,
> > for example, when consumers probe defer or suspend.
> > 
> > Note that there are likely votes from other processors for these rpmh
> > regulators (at least for l15b) but the OS should not rely on that in any
> > case.
> > 
> > Included is also a patch that adds the missing HID supplies for the
> > T14s. It was a corresponding change for the CRD that made me look into
> > this to make sure these supplies were not disabled during suspend or on
> > probe deferrals.

> This looks good, too bad SL7 was left out :( I'll take care of that
> myself

Thanks for catching that. It seems my grep pattern was too specific
given that you had dropped the voltages from the SL7 regulator labels
whereas every other X1 board copy-pasted the CRD which had them:

	vreg_l12b_1p2: ldo12 {

	vreg_l12b: ldo12 {

Like you, I'd prefer if they were not there (especially since they are
not even correct with 3 V rails having "2p9" suffixes), but I see now
that this pattern have been used also for some older Qualcomm machines.

Perhaps we can drop them throughout, at least for X1, for consistency.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Thanks for reviewing.

Johan

