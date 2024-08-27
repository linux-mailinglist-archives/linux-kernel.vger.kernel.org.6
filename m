Return-Path: <linux-kernel+bounces-303469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3619960C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5461F22995
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FF1BA295;
	Tue, 27 Aug 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nr2s0ztQ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DF1BA270
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766408; cv=none; b=CA4GaRl/FXF37Mu8uQ/nS3DyaKaxYZMulFI34o3P4xIrPUt/WB4qnoAArZCJGsz7ezoAfI29oGY8aPn7YqIO9tuOcuvzB8fGWlQ/AEr5vaolVdYFPNKj32iAXIIGARE+gXS/bBf5/RmYwcxXXlSfv8RBkrbbCXn6vyAc7nwc8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766408; c=relaxed/simple;
	bh=bXHTM+clE4uDgk0I3cqw6MwL5gr7F0KRpTGdFV7uTPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+26CU3ve0doPtXtlt+Cn32f6jkZpt6Ly+q0ku74WbabVrxjT2kdDBekhq01v/ecwWc0hAXbHWtykooSdnzbe7j5/PtX7PVnnIMkpUOdf+BZxAwIw5QlQj0pejEN8ax4s9+1Mpea/Lt60q4v8Q7A0ChMlR296OEGd46npfTFdTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nr2s0ztQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hlPrE/i66VLLy1xiubvwi0Q8qedqtB5Y23lCpG8GyVk=; b=Nr2s0ztQLQqYnHeWHXlSgKJiyE
	7vzu94jaDGRbS90SOyABh1sKVKFOWDTZxaTT1jngi7quM2eAsyoqt4MiEvH6kjSkcKUXz+VrAtLBP
	Ia7RdIU/UIgOcw7xzyAONrmPheGQ2qtxtZhvtHL2ESR80FLyGOhP3YCgVMzX/JUacmjPFZxeloWqB
	biKZ81ug67iVH4uR+qhT175sgcillXXjRv25b2dACcbpPioTfdPu2PPXW2yTkZ73LpGwTXM8Pcn74
	d386H6ju7kRzFO+5mkHHtM9+ICmDLyrnqqzYoYI5Hd234+GouKLXqXaQQyxiW7WCuxkl+pNKhwbyA
	I84DWtRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37400)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1siwWm-00076I-1I;
	Tue, 27 Aug 2024 14:46:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1siwWg-0003UR-2z;
	Tue, 27 Aug 2024 14:46:26 +0100
Date: Tue, 27 Aug 2024 14:46:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: krzk@kernel.org, andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] amba: make amba_bustype constant
Message-ID: <Zs3YsjunDlGSaW4c@shell.armlinux.org.uk>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823064203.119284-1-kunwu.chan@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the amba_bustype variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.

I'm happy with this, but as AMBA bus maintainer, it needs to go to
my patch system. Please see details in my signature. Please also
note that I'm limited in terms of my time in front of the screen at
the moment, so I'm not very responsive at the moment. Thanks.

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

