Return-Path: <linux-kernel+bounces-428240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CA79E0BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840BE281F20
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9841DE4D2;
	Mon,  2 Dec 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPCtE/dF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150676C61;
	Mon,  2 Dec 2024 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166577; cv=none; b=hbHAWSKjtDJo8rIFbW2vpa+tljTDmCEghHJOWob+gs6RaF8vyp3pgptPJyRwphFqUtKkaVpwi5SCYYNrvArTHcfZ5AVEMGi2B6bkj22yJ8r766H3Mnpy3x+zgA35hqvxWgBl1aoo3Du7onsnrYp93pfQpcdr0O18n4GQxIPWft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166577; c=relaxed/simple;
	bh=QTsPHl/Taoe+yxX9OpQ/uU1H5wwWQvNcBX5kRjq+fj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3TRyQlaTwg6gL81jeXkUkGOpwD9z1cDHImJFwy2YXEW2trxjVITSuAXYYVRbWvNtd52pLK4lNCXkDJkevjM+q3vjMXXPkt6qf21/txaO41L/cSw4vmOwVCWGqJcJ01ccl4Y/pKORH5CRivyENzmrx78BtnYfh/8agtL1ykOz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPCtE/dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EDDC4CED2;
	Mon,  2 Dec 2024 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166576;
	bh=QTsPHl/Taoe+yxX9OpQ/uU1H5wwWQvNcBX5kRjq+fj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPCtE/dFV7A5roSHN6K4OhtVY3k0oNFIUKlB5q0yWN3geajSkvVKJMxJSfaff6/NI
	 vJexJbTeeNGaFff4zg8M/ONkYcLudqUeHaq+wWp8u9xuc7dWaie53Zh5S5zidm+teu
	 dYngr+C+WxIduQsykkwV3S9qiT6iiZiUM/NjICenDNSIZVybOQQDZEbgvf82QCvYJA
	 BZeDK1V/8bfuLmqPszLIoY4Re0bpoqrSqRD5dy/GQ3TEahs1RcCo7SARz1sq1R5Nrx
	 MT0Pg5QM+Ci6alApUJcfN5qJqY6KDr+hMYpLzmVTjcF0NATUlirqswGfN5lPcWGDxK
	 ZZWdD2u8txk8Q==
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Henry Bell <dmoo_dv@protonmail.com>,
	E Shattow <e@freeshell.de>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
Date: Mon,  2 Dec 2024 19:09:26 +0000
Message-ID: <20241202-wrench-bleep-14eaff07451e@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127154958.71094-1-e@freeshell.de>
References: <20241127154958.71094-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=592; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=0GV8cg7FLdiPSZtkVCNPFpdPDhaQh8JlY3YnOLmT0S4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl+rM9e1XXknAtcqlU88XJQp0O6sWkmf/PMzllKXJ+NB ZMdt3B3lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCKlDxn+6dcWKzV+uy4oNLnD MXPVh9WRT26an/D8/t18wqqPyRtfTWBkaMzs3LpPcOmaDxosldJXfs89vMAl7EPg/KLjHgaV501 fMQAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 27 Nov 2024 07:49:22 -0800, E Shattow wrote:
> Enable host mode JH7110 on-chip USB for Milk-V Mars by setting host mode
> and connect vbus pinctrl.
> 
> This functionality depends on setting the USB over-current register to
> disable at bootloader phase, for example U-Boot:
> https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
      https://git.kernel.org/conor/c/708d55db3edb

Thanks,
Conor.

